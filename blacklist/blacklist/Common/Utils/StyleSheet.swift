//
//  StyleSheet.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/3/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

struct StyleSheet {
    // Define here fonts, colors and design constants.
    enum Font: String {
        case robotoRegular = "Roboto-Regular"
        case robotoLight = "Roboto-Light"
        case lobsterRegular = "Lobster-regular"
    }

    struct Color {

        // Colors used in the TabBar
        struct TabBar {
            static let background = UIColor(hex: 0x383E47)
            static let plusButtonBackground = UIColor(hex: 0x212832)
            static let tintColor = UIColor(hex: 0xFFFFFF)
        }

        struct Home {
            static let emptyHeaderText = UIColor(hex: 0x222831)
            static let emptySubHeaderText = UIColor(hex: 0x222831)
        }

        struct Debtors {
            static let background = UIColor(hex: 0xDDE4CE)
            static let green = UIColor(hex: 0x2FBE9C)
        }
    }
}
