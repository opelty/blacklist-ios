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

    private let plusButton: UIView = UIView()
    private let plusButtonImageView: UIImageView = UIImageView(image: UIImage(named:"plus"))
    weak var blackListTabBardelegate: BlackListTabBarDelegate?

    // MARK: - Life cycle

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        customizeButton()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Sets insets on image tab bar to center it.

        // We divided by 2 the final value because is require to set the same value on
        // top, bottom, left, right insets to avoid shrink the image.
        let distanceFromMiddle: CGFloat = (plusButtonXPosition / 2 - tabBarImageSize) / 2
        let centerVertically: CGFloat =  (frame.height - tabBarImageSize / 2) / 2

        let upcommingItem = items?.first
        let lendingItem = items?.last

        upcommingItem?.imageInsets = UIEdgeInsets(top: centerVertically, left: -distanceFromMiddle, bottom: -centerVertically, right: distanceFromMiddle)
        lendingItem?.imageInsets = UIEdgeInsets(top: centerVertically, left: distanceFromMiddle, bottom: -centerVertically, right: -distanceFromMiddle)
    }

    // MARK: - Private Methods

    private func setup() {
        backgroundColor = StyleSheet.Color.TabBar.background
        tintColor = StyleSheet.Color.TabBar.tintColor
        addSubview(plusButton)
        plusButton.addSubview(plusButtonImageView)
    }

    private func customizeButton() {
        plusButton.frame = CGRect(x: plusButtonXPosition, y: plusButtonYPosition, width: plusButtonHeight, height: plusButtonHeight)
        plusButton.layer.cornerRadius = plusButtonHeight / 2

        plusButtonImageView.frame.origin.x = plusButtonHeight / 2 - 15
        plusButtonImageView.frame.origin.y = plusButtonHeight / 2 - 15
        plusButton.backgroundColor = StyleSheet.Color.TabBar.plusButtonBackground
        plusButton.clipsToBounds = false
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let touch = touches.first {
            if touch.view == plusButton {
                let imageView = plusButton.subviews.first
                imageView?.animate(.scalate(toX: 0.3, toY: 0.3), .scalate(toX: 1.0, toY: 1.0))
                imageView?.animate(.rotated(angle: CGFloat.pi))
                plusButton.animate(.scalate(toX: 0.95, toY: 0.95), .scalate(toX: 1.0, toY: 1.0))
                blackListTabBardelegate?.plusButtonClicked()
            }
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let pointForTargetView = plusButton.convert(point, from: self)

        return plusButton.bounds.contains(pointForTargetView) ? plusButton : super.hitTest(point, with: event)
    }
}
