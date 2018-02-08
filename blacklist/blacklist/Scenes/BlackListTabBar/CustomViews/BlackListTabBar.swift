//
//  BlackListTabBar.swift
//  blacklist
//
//  Created by Santiago Carmona Gonzalez on 2/7/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

protocol BlackListTabBarDelegate: UITabBarDelegate {
    func plusButtonClicked()
}

class BlackListTabBar: UITabBar {

    // MARK: - Vars & Constants

    private let plusButtonHeight: CGFloat = 95
    private let plusButtonYPosition: CGFloat = -31

    /// Apple Default size for TabBarItem image
    private let tabBarImageSize: CGFloat = 30

    private var plusButtonXPosition: CGFloat {
        return self.frame.midX - plusButtonHeight / 2
    }

    weak var blackListTabBardelegate: BlackListTabBarDelegate?

    // MARK: - Life cycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func draw(_ rect: CGRect) {
        self.addSubview(createPlusButton())
    }

    // MARK: - Private Methods

    private func setup() {
        backgroundColor = StyleSheet.Color.TabBar.background
        tintColor = StyleSheet.Color.TabBar.tintColor
    }

    private func createPlusButton() -> UIButton {
        let plustButton = UIButton(frame: CGRect(x: plusButtonXPosition, y: plusButtonYPosition, width: plusButtonHeight, height: plusButtonHeight))
        plustButton.backgroundColor = .clear
        plustButton.addCircleLayer(backgroundColor: StyleSheet.Color.TabBar.plusButtonBackground)
        plustButton.setImage(UIImage(named: "plus"), for: .normal)
        plustButton.imageView?.layer.zPosition = 1
        plustButton.addTarget(self, action: #selector(plustButtonAction), for: .touchUpInside)
        plustButton.clipsToBounds = false
        return plustButton
    }

    @objc private func plustButtonAction(sender: UIButton) {
        // TODO: PERFORM AN ANIMATION WITH THE BUTTON

        blackListTabBardelegate?.plusButtonClicked()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Sets insets on image tab bar to center it.
        let distanceFromMiddle: CGFloat = plusButtonXPosition / 2 - tabBarImageSize
        let centerVertically: CGFloat =  -((frame.height - tabBarImageSize) / 2)

        let upcommingItem = items?.first
        let lendingItem = items?.last

        upcommingItem?.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: centerVertically, right: distanceFromMiddle)
        lendingItem?.imageInsets = UIEdgeInsets(top: 0, left: distanceFromMiddle, bottom: centerVertically, right: 0)

    }

}

extension UIView {
    func addCircleLayer(lineWidth: CGFloat = 0.0, backgroundColor: UIColor, strokeColor: UIColor? = nil) {

        let halfSize = bounds.height / 2

        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: halfSize, y: halfSize),
            radius: halfSize - lineWidth,
            startAngle: CGFloat(0),
            endAngle:CGFloat(Double.pi * 2),
            clockwise: true
        )

        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath

        circleLayer.fillColor = backgroundColor.cgColor
        circleLayer.strokeColor = strokeColor?.cgColor
        circleLayer.lineWidth = lineWidth

        layer.addSublayer(circleLayer)
    }
}
