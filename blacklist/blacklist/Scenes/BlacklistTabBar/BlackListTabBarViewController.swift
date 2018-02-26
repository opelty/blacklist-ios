//
//  BlackListTabBarViewController.swift
//  blacklist
//
//  Created by Santiago Carmona Gonzalez on 2/7/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class BlackListTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Private Methods

    private func setupTabBar() {
        if let blackListTabBar = tabBar as? BlackListTabBar {
            blackListTabBar.blackListTabBardelegate = self
        }
    }

}

// MARK: - UITabBarDelegate conformance

extension BlackListTabBarViewController: BlackListTabBarDelegate {
    func plusButtonClicked() {
        // TODO: Make plus action
        print("Plus button in tab bar was clicked.")
    }
}
