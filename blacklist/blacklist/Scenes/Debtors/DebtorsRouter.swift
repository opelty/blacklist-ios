//
//  DebtorsRouter.swift
//  blacklist
//
//  Created by Santiago Carmona Gonzalez on 2/22/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class DebtorsRouter: Router {
    // Add transition methods here...

    func goToContinueAction() { // TODO: Finish this
        print("Going to continue screen...")

        go(to: "EmptyScreen", sender: nil)
    }

    // MARK: - Overrides

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Prepare segue here if it's neccesary....
    }
}
