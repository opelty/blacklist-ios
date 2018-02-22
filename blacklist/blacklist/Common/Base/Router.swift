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

    func presentViewController(withIdentifier identifier: String, fromStoryboard name: String, bundle: Bundle? = nil, animated: Bool = true, completion: (() -> Void)?) {
        let viewControllerToPresent = UIStoryboard(name: name, bundle: bundle).instantiateViewController(withIdentifier: identifier)
        viewController?.present(viewControllerToPresent, animated: animated, completion: completion)
    }

    func presentInitialViewController(fromStoryboard name: String, bundle: Bundle? = nil, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let viewControllerToPresent = UIStoryboard(name: name, bundle: bundle).instantiateInitialViewController() else {
            assertionFailure("Unexpected initial view controller from storyboard name:  \(name)")
            return
        }
        viewController?.present(viewControllerToPresent, animated: animated, completion: completion)
    }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
}
