//
//  BasePresenter.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/2/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation

protocol View: class { }

class Presenter {
    public private(set) weak var view: View?
    public private(set) weak var router: Router?
    
    public func attach(view: View) {
        self.view = view
    }
    
    public func register(router: Router) {
        self.router = router
    }
    
    public func deallocateView() {
        self.view = nil
    }
    
    public func deallocateRouter() {
        self.router = nil
    }
}
