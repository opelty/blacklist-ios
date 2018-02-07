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
    public enum UpcomingAction {
        case phone
        case check
    }

    fileprivate static let leadingPadding: CGFloat = 15.0
    fileprivate static let trailingPadding: CGFloat = 15.0
    fileprivate var containerViewOriginConstant: CGPoint = CGPoint.zero

    @IBOutlet fileprivate weak var actionsViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var actionsView: UIView!

    @IBOutlet fileprivate weak var checkButton: UIButton!
    @IBOutlet fileprivate weak var phoneButton: UIButton!

    private var callback: UpcomingActionCompletion?

    override func awakeFromNib() {
        super.awakeFromNib()

        let panGuesture = UIPanGestureRecognizer(target: self, action: #selector(panActionRecognizer(_:)))

        panGuesture.delegate = self
        containerView.addGestureRecognizer(panGuesture)
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
        let bounceLeft = Animation.bounce(
            bounceOffset: containerView.frame.origin.x - UpcomingTableViewCell.leadingPadding
        )

        let bounceRigth = Animation.bounce(
            bounceOffset: actionsView.frame.origin.x
        )

        containerView.animate(bounceLeft, bounceRigth)
    }

    public func colapse(animated: Bool = true) {
        let execution = { [unowned self] in
            self.containerView.frame.origin.x = self.actionsView.frame.origin.x
        }

        if animated {
            //UIView.animate(withDuration: Constants.Animations.duration, animations: execution)
        } else {
            execution()
        }
    }

    // MARK: - Cell Actions

    fileprivate func performMovement(for gestureTranslation: CGPoint) {
        let dx = fabs(self.frame.origin.x - gestureTranslation.x)
        let actionsViewMaximumWidth = actionsViewTrailingConstraint.constant
        let actionViewContainerViewDistance = (
            containerView.frame.origin.x - actionsView.frame.origin.x
        )

        if gestureTranslation.x > 10 {
            // Rigth movement behavior.
            if actionViewContainerViewDistance < -UpcomingTableViewCell.trailingPadding {
                // Let's move the containerView in order to hide the actions.
                containerView.frame.origin.x = containerViewOriginConstant.x + dx

            }
        } else if gestureTranslation.x < 10 {
            // Left movement behavior.

            if fabs(actionViewContainerViewDistance) < actionsViewMaximumWidth {
                // Let's move the containerView in order to show the actions.
                containerView.frame.origin.x = containerViewOriginConstant.x - dx
            }
        }
    }

    fileprivate func finishMovement() {
        let actionsViewMaximumWidth = actionsViewTrailingConstraint.constant
        let actionViewContainerViewDistance = (
            containerView.frame.origin.x - actionsView.frame.origin.x
        )

        // Check the last state and animate movement difference.
        let halfActionsViewWidth = actionsViewMaximumWidth / 2

        UIView.animate(withDuration: Animation.defaultDuration) { [unowned self] in
            if fabs(actionViewContainerViewDistance) > halfActionsViewWidth {
                // Finish showing
                self.containerView.frame.origin.x = -actionsViewMaximumWidth
            } else {
                // Finish hiding
                self.containerView.frame.origin.x = self.actionsView.frame.origin.x
            }
        }
    }

    @objc func panActionRecognizer(_ sender: UIPanGestureRecognizer) {
        guard fabs(sender.velocity(in: self).x) > 30 else { return }

        switch sender.state {
        case .began:
            containerViewOriginConstant = containerView.frame.origin
            break
        case .changed:
            performMovement(for: sender.translation(in: self))
            break
        default:
            finishMovement()
            break
        }
    }

    // MARK: - IBActions
    @IBAction fileprivate func didPressAction(_ sender: UIButton) {
        if sender == checkButton {
            callback?(self, .check)
        } else if sender == phoneButton {
            callback?(self, .phone)
        }
    }

}
