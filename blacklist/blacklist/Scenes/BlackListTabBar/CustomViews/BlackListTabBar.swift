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

    private var plusButton: UIButton = UIButton()
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
        createPlusButton()
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

    // MARK: - Private Methods

    private func setup() {
        backgroundColor = StyleSheet.Color.TabBar.background
        tintColor = StyleSheet.Color.TabBar.tintColor
    }

    private func createPlusButton() {
        plusButton.frame = CGRect(x: plusButtonXPosition, y: plusButtonYPosition, width: plusButtonHeight, height: plusButtonHeight)
        plusButton.layer.cornerRadius = plusButtonHeight / 2
        plusButton.backgroundColor = StyleSheet.Color.TabBar.plusButtonBackground
        plusButton.setImage(UIImage(named: "plus"), for: .normal)
        plusButton.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
        plusButton.clipsToBounds = false
        self.addSubview(plusButton)
    }

    @objc private func plusButtonAction(sender: UIButton) {
        plusButton.animate(.rotated(angle: CGFloat.pi))
        blackListTabBardelegate?.plusButtonClicked()
    }
}
