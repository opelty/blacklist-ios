//
//  HomeViewController.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/2/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    fileprivate let presenter = HomePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Let's configure the presenter
        presenter.attach(view: self)
        presenter.register(router: HomeRouter(viewController: self))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router?.prepare(for: segue, sender: sender)
    }
}

extension HomeViewController: HomeView {
    func doSomethingUI() {
        print("Hello World")
    }
}
