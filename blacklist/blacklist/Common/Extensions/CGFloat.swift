//
//  CGFloat.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/10/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

extension CGFloat {
    var percentage: CGFloat {
        if self >= 0 && self <= 1 {
            return self
        } else if self > 1 {
            return 1.0
        } else {
            return 0.0
        }
    }
}
