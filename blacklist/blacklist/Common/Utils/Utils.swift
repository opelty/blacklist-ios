//
//  Utils.swift
//  blacklist
//
//  Created by Santiago Carmona Gonzalez on 2/23/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

struct Utils {

    /**
     * Returns the size of the screen using: `UIScreen.main.bounds.size`
     */
    static var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }

    /**
     * Returns the width of the screen using: `UIScreen.main.bounds.size.width`
     */
    static var screenWidth: CGFloat {
        return screenSize.width
    }

    /**
     * Returns the height of the screen using: `UIScreen.main.bounds.size.height`
     */
    static var screenHeight: CGFloat {
        return screenSize.height
    }
}
