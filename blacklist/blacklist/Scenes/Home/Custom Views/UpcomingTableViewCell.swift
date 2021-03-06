//
//  UpcomingTableViewCell.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/4/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

typealias UpcomingActionCompletion = ((UpcomingTableViewCell, UpcomingTableViewCell.UpcomingAction) -> Void)

class UpcomingTableViewCell: UITableViewCell {
    static public var identifier: String {
        return String(describing: self)
    }

    fileprivate static let leadingPadding: CGFloat = 15.0
    fileprivate static let trailingPadding: CGFloat = 15.0
    fileprivate var containerViewOriginConstant: CGPoint = CGPoint.zero

    @IBOutlet fileprivate weak var actionsViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var actionsView: UIView!
    @IBOutlet fileprivate weak var debtorNameLabel: UILabel!
    @IBOutlet fileprivate weak var amountLabel: UILabel!
    @IBOutlet fileprivate weak var deadlineLabel: UILabel!

    private var callback: UpcomingActionCompletion?
    public private(set) var debtor: Debtor!
    public private(set) var period: Period!

    override func awakeFromNib() {
        super.awakeFromNib()

        let panGuesture = UIPanGestureRecognizer(target: self, action: #selector(panActionRecognizer(_:)))

        panGuesture.delegate = self
        panGuesture.delaysTouchesBegan = true
        panGuesture.delaysTouchesEnded = true
        panGuesture.cancelsTouchesInView = true
        panGuesture.maximumNumberOfTouches = 1
        containerView.addGestureRecognizer(panGuesture)

        actionsView.alpha = 0.0
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 8.0

        actionsView.clipsToBounds = true
        actionsView.layer.cornerRadius = 8.0

        containerViewOriginConstant = containerView.bounds.origin
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

        if selected {
            self.alpha = 0.6
        } else {
            self.alpha = 1.0
        }
    }

    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let panGuesture = gestureRecognizer as? UIPanGestureRecognizer {
            let velocity = panGuesture.velocity(in: self)

            return fabs(velocity.x) > fabs(velocity.y)
        }

        return true
    }

    // MARK: - Public interface

    public func registerHandler(didPerformAction callback: @escaping UpcomingActionCompletion) {
        self.callback = callback
    }

    public func bounce() {
        guard containerView.frame.origin.x == actionsView.frame.origin.x else { return }

        let bouncePoint = containerView.frame.origin
        let left = bouncePoint.x - UpcomingTableViewCell.leadingPadding
        let right = actionsView.frame.origin.x

        let bounceLeft = Animation.traslation(to: CGPoint(x: left, y: bouncePoint.y))
        let bounceRight = Animation.traslation(to: CGPoint(x: right, y: bouncePoint.y))

        containerView.animate(bounceLeft, bounceRight)
    }

    public func colapse(animated: Bool = true) {
        var point = self.actionsView.frame.origin
        point.y = containerView.frame.origin.y

        if animated {
            containerView.animate(.traslation(to: point))
        } else {
            containerView.frame.origin = point
        }
    }

    public func setupCell(for debtor: Debtor, period: Period) {

        // Let's add the context to the cell
        self.period = period
        self.debtor = debtor

        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full

        debtorNameLabel.text = debtor.fullName
        deadlineLabel.text = dateFormatter.string(from: period.date)

        if let formattedAmount = formatter.string(from: period.payment as NSNumber) {
            if let currencySymbol = Locale.current.currencySymbol {
                amountLabel.text = formattedAmount.remove(substring: currencySymbol)
            } else {
                amountLabel.text = formattedAmount
            }
        } else {
            amountLabel.text = "0.00"
        }
    }

    // MARK: - IBActions
    @IBAction fileprivate func didPressAction(_ sender: UIButton) {
        guard let action = ActionTags.init(rawValue: sender.tag) else {
            return
        }

        switch action {
        case .phone:
            callback?(self, .call(to: debtor.phone))
        case .paid:
            callback?(self, .mark(to: .paid))
        case .unpaid:
            callback?(self, .mark(to: .unpaid))
        }
    }

    // MARK: - Touches handler

    fileprivate func performMovement(for gestureTranslation: CGPoint) {
        let x = fabs(gestureTranslation.x)
        let actionsViewMaximumWidth = actionsViewTrailingConstraint.constant
        let actionViewContainerViewDistance = (
            containerView.frame.origin.x - actionsView.frame.origin.x
        )

        if gestureTranslation.x > 0 {
            // Rigth movement behavior.

            if actionViewContainerViewDistance < 0 {
                // Let's move the containerView in order to hide the actions.
                containerView.frame.origin.x = containerViewOriginConstant.x + x
            }
        } else if gestureTranslation.x < 0 {
            // Left movement behavior.

            if fabs(actionViewContainerViewDistance) < actionsViewMaximumWidth {
                // Let's move the containerView in order to show the actions.
                containerView.frame.origin.x = containerViewOriginConstant.x - x
            }
        }

        let alpha = fabs(containerView.frame.origin.x) / actionsViewMaximumWidth
        actionsView.alpha = alpha.percentage
    }

    fileprivate func finishMovement(for translation: CGPoint, velocity: CGPoint) {
        let actionsViewMaximumWidth = actionsViewTrailingConstraint.constant
        let factor = min(fabs(containerView.bounds.size.width / velocity.x), 0.5)
        let x = translation.x > 0 ? actionsView.frame.origin.x : -actionsViewMaximumWidth
        let alpha = translation.x > 0 ? 0.0 : 1.0

        UIView.setAnimationCurve(.easeOut)
        UIView.animate(withDuration: TimeInterval(factor)) { [unowned self] in
            self.containerView.frame.origin.x = x
            self.actionsView.alpha = CGFloat(alpha)
        }

    }

    @objc func panActionRecognizer(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            containerViewOriginConstant = containerView.frame.origin
            break
        case .changed:
            performMovement(for: sender.translation(in: self))
            break
        default:
            finishMovement(for: sender.translation(in: self), velocity: sender.velocity(in: self))
            break
        }
    }
}

extension UpcomingTableViewCell {
    public enum UpcomingAction {
        public enum Mark {
            case paid
            case unpaid
        }

        case call(to: String?)
        case mark(to: Mark)
    }

    private enum ActionTags: Int {
        case paid = 300
        case phone = 100
        case unpaid = 200
    }
}
