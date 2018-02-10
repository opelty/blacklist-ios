//
//  Router.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/2/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class Router {
    public private(set) weak var viewController: Viewable?

    required init(viewController: Viewable) {
        self.viewController = viewController
    }

    func go(to: String, sender: Any?) {
        viewController?.performSegue(withIdentifier: to, sender: sender)
    }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
}
