//
//  BlackListTabBarViewController.swift
//  blacklist
//
//  Created by Santiago Carmona Gonzalez on 2/7/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class BlackListTabBarViewController: UITabBarController, ViewControllerProtocol {

    // MARK: - Vars & Constants

    typealias Presenter = BlackListTabBarPresenter
    typealias Router = BlackListTabBarRouter

    var presenter: BlackListTabBarPresenter!
    var router: BlackListTabBarRouter?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure { (context) -> (presenter: Presenter, router: Router?) in            
            let presenter = Presenter()
            let router = Router(viewController: context)

            return (presenter: presenter, router: router)
        }

        configure()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // Methods

    private func configure() {
        setupTabBar()
    }

    private func setupTabBar() {
        if let blackListTabBar = tabBar as? BlackListTabBar {
            blackListTabBar.blackListTabBardelegate = self
        }
    }

}

// MARK: - UITabBarDelegate conformance

extension BlackListTabBarViewController: BlackListTabBarDelegate {
    func plusButtonClicked() {
        router?.debtorsList()
    }
}
