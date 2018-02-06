//
//  ViewController.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/5/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

struct ViewControllerConfiguration<P: Presenter, R: Router> {
    public private(set) var presenter: P
    public private(set) var router: R?
}

protocol Viewable: class {
    func performSegue(withIdentifier identifier: String, sender: Any?)
}

protocol ViewControllerProtocol: Viewable {
    associatedtype P: Presenter
    associatedtype R: Router
    var presenter: P! { get set }
}

extension UIViewController: Viewable { }

extension ViewControllerProtocol {
    func configure(handler: ((Viewable) -> P!)) {
        presenter = handler(self)
        presenter.attach(view: self as? Self.P.V)
    }
}
