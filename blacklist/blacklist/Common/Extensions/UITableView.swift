//
//  UITableView.swift
//  blacklist
//
//  Created by Santiago Carmona gonzalez on 3/3/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

extension UITableView {

    /**
     * Sets a MessageView view as the `backgroundView` of the table
     * - parameters:
     *   - header: `String` text wich will be displayed in the **center** of the view
     *   - subheader: `String` text which will be displayed **below** the header
     */
    func addPlaceholderView(withHeader header: String, subheader: String? = nil) {
        self.backgroundView = MessageView(frame: self.frame, headerText: header, subheaderText: subheader)
    }
}
