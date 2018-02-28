//
//  BlackListTabBarRouter.swift
//  blacklist
//
//  Created by Santiago Carmona Gonzalez on 2/22/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class BlackListTabBarRouter: Router {
    // Add transition methods here...

    func debtorsList() {
        presentInitialViewController(fromStoryboard: "Debtors")
    }

    // MARK: - Overrides

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Prepare segue here if it's neccesary....
    }
}
