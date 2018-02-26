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
            static let background = #colorLiteral(red: 0.2196078431, green: 0.2431372549, blue: 0.2784313725, alpha: 1)
            static let plusButtonBackground = #colorLiteral(red: 0.1276926696, green: 0.157300055, blue: 0.1955993772, alpha: 1)
            static let tintColor = #colorLiteral(red: 0.999904573, green: 1, blue: 0.9998722672, alpha: 1)
        }

        struct Home {
            static let emptyHeaderText = UIColor(hex: 0x222831)
            static let emptySubHeaderText = UIColor(hex: 0x222831)
        }

        struct Debtors {
            static let background = #colorLiteral(red: 0.864806354, green: 0.8960095048, blue: 0.8077570796, alpha: 1)
            static let green = #colorLiteral(red: 0.1842306554, green: 0.7449585795, blue: 0.6130102873, alpha: 1)
        }
    }
}
