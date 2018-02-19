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
    struct Font {
        static let robotoRegular = "Roboto-Regular"
        static let robotoLight = "Roboto-Light"
    }

    struct Color {

        // Colors used in the TabBar
        struct TabBar {
            static let background = #colorLiteral(red: 0.2190301418, green: 0.2435238063, blue: 0.2776792347, alpha: 1)
            static let plusButtonBackground = #colorLiteral(red: 0.1276926696, green: 0.157300055, blue: 0.1955993772, alpha: 1)
            static let tintColor = #colorLiteral(red: 0.999904573, green: 1, blue: 0.9998722672, alpha: 1)
        }

        struct Home {
            static let emptyHeaderText = UIColor(hex: 0x222831)
            static let emptySubHeaderText = UIColor(hex: 0x222831)
        }
    }
}
