//
//  Array.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/26/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation

extension Array {
    func has(index: Array.Index) -> Bool {
        return index < self.count
    }
}
