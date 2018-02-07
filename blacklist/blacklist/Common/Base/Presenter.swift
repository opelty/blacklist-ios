//
//  BasePresenter.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/2/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation

protocol View: class {
    func go(to: String, sender: Any?)
}

protocol Presenter: class {
    associatedtype V

    var view: V? { get set }

    func attach(view: V?)
    func deattach()

    var isAttached: Bool { get }
}

extension Presenter {
    var isAttached: Bool {
        return view != nil
    }

    func attach(view: V?) {
        self.view = view
    }

    func deattach() {
        self.view = nil
    }
}
