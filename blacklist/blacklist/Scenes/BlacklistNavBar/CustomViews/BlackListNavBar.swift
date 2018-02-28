//
//  BlackListNavBar.swift
//  blacklist
//
//  Created by Jose Daniel Lopez Franco on 2/11/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class BlackListNavBar: UINavigationController {

    // MARK: - Vars & Constants

    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let screenWidth = UIScreen.main.bounds.width
    let navBarTitleFont = StyleSheet.Font.lobsterRegular.rawValue

    public private(set) var blacklistNavigationItem: UINavigationItem?
    public private(set) var blacklistNavigationBar: UINavigationBar?

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

        setUpNavBar()
        setUpStatusbar()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func setUpStatusbar() {

         // MARK: - Setting the statusBar

        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: statusBarHeight))
        statusBarView.backgroundColor = StyleSheet.Color.TabBar.background

        self.view.addSubview(statusBarView)

    }

    func setUpNavBar() {
        // MARK: - Setting the navBar
        blacklistNavigationBar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight, width: screenWidth, height: 44))
        blacklistNavigationBar?.barTintColor = StyleSheet.Color.TabBar.background
        blacklistNavigationBar?.isTranslucent = false
        blacklistNavigationBar?.tintColor = .white
        blacklistNavigationBar?.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name: navBarTitleFont, size: 25.0)!,
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]

        // MARK: - Setting navBar Items
        blacklistNavigationItem = UINavigationItem(title: "Blacklist")

        let settingsItem = UIBarButtonItem(
            image: UIImage(named: "settings"),
            style: .done,
            target: nil,
            action: #selector(self.settingsButtonAction)
        )

        if let blacklistNavigationBar = blacklistNavigationBar, let blacklistNavigationItem = blacklistNavigationItem {
            blacklistNavigationItem.rightBarButtonItem = settingsItem
            blacklistNavigationBar.setItems([blacklistNavigationItem], animated: false)

            self.view.addSubview(blacklistNavigationBar)
        }
    }

    @objc func backButtonAction() {
        if topViewController?.navigationController?.viewControllers.count == 1 {
            topViewController?.navigationController?.dismiss(animated: true, completion: nil)
        } else {
            popViewController(animated: true)
        }
    }

    @objc func settingsButtonAction() {
        print("los Ajustos los ajustes!!!")
    }

    fileprivate func addBackItem() {
        guard let blacklistNavigationItem = blacklistNavigationItem else {
            return
        }

        blacklistNavigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "back"),
            style: .done,
            target: nil,
            action: #selector(self.backButtonAction)
        )
    }

    fileprivate func removeBackItem() {
        guard let blacklistNavigationItem = blacklistNavigationItem else {
            return
        }

        blacklistNavigationItem.leftBarButtonItem = nil
    }
}

extension BlackListNavBar: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let rootViewController = navigationController.viewControllers.first else { return }

        if viewController == rootViewController {
            // Let's hide the back button
            removeBackItem()
        } else {
            // Let's show the back button
            addBackItem()
        }
    }
}
