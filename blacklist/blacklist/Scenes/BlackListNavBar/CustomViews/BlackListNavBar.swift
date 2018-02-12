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
    let getStatusBarHeight = UIApplication.shared.statusBarFrame.height
    let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: UIApplication.shared.statusBarFrame.width, height: UIApplication.shared.statusBarFrame.height))

    override func viewDidLoad() {
     

    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setUpNavBar() {
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: getStatusBarHeight, width: self.view.frame.width, height: 0))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "La listBlack")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.pause, target: nil, action:  #selector(backButtonAction()), for: .touchUpInside)
        let back = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.bookmarks, target: nil, action: "")
        navItem.rightBarButtonItem = doneItem
        navItem.leftBarButtonItem = back
        navBar.setItems([navItem], animated: false)
        navBar.barStyle = .default
        navBar.barTintColor = StyleSheet.Color.TabBar.background
        statusBarView.backgroundColor = StyleSheet.Color.TabBar.background
        view.addSubview(statusBarView)
        
    }
    
    func backButtonAction() {
        print("Pa atra <-- Pa atra")
    }
    
    func settingsButtonAction() {
        print("los Ajustos los ajustes!!!")
    }

}
