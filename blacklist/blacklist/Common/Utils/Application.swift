//
//  Application.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/5/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import UIKit

class Application {
    class func open(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
}
