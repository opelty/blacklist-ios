//
//  ViewController.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/5/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

protocol Viewable: class {
    func performSegue(withIdentifier identifier: String, sender: Any?)
    func present(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?)
}

protocol ViewControllerProtocol: Viewable {
    associatedtype P: Presenter
    associatedtype R: Router
    var presenter: P! { get set }
    var router: R? { get set }
}

extension UIViewController: Viewable {}

extension ViewControllerProtocol {
    func configure(handler: ((Viewable) -> (presenter: P, router: R?))) {
        let context = handler(self)

        presenter = context.presenter
        presenter.attach(view: self as? Self.P.V)

        router = context.router
    }

    func go(to: SegueIndentifier, sender: Any?) {
        router?.go(to: to, sender: sender)
    }
}
