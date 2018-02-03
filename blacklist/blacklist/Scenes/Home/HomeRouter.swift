//
//  HomeRouter.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/2/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class HomeRouter: Router {
    // Add transition methods here...
    
    func goSettings() {
        viewController?.performSegue(withIdentifier: "TEST_SEGUE", sender: nil)
    }
    
    // MARK: - Overrides
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Prepare segue here if it's neccesary....
    }
}
