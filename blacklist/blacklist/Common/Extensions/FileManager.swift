//
//  FileManager.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/3/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation

extension FileManager {
    func remove(paths: String...) throws {
        for path in paths {
            if fileExists(atPath: path) {
                try self.removeItem(atPath: path)
            }
        }
    }
}
