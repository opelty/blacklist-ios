//
//  UIFont.swift
//  blacklist
//
//  Created by Santiago Carmona Gonzalez on 2/24/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

extension UIFont {
    static func get(withType type: StyleSheet.Font, size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
