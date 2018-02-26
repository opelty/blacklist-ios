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

    override func viewDidLoad() {
        super.viewDidLoad()
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

        let navBar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight, width: screenWidth, height: 44))
        navBar.barTintColor = StyleSheet.Color.TabBar.background

        navBar.isTranslucent = false

        navBar.tintColor = .white

         // MARK: - Setting navBar Items

        let navItem = UINavigationItem(title: "Blacklist")
        let settingsItem = UIBarButtonItem(image: UIImage(named: "settings"), style: .done, target: nil, action: #selector(self.settingsButtonAction))
        let backItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: nil, action: #selector(self.backButtonAction))

        navItem.rightBarButtonItem = settingsItem
        navItem.leftBarButtonItem = backItem
        navBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont(name: navBarTitleFont, size: 25.0)!,
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]

        navBar.setItems([navItem], animated: false)

        self.view.addSubview(navBar)
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
}
