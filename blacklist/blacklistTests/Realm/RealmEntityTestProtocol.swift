//
//  RealmEntityTestProtocol.swift
//  blacklistTests
//
//  Created by Mateo Olaya Bernal on 2/25/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation

protocol RealmEntityTestProtocol {
    // You must test CRUD in the realm's entities
    func testCreate()
    func testRead()
    func testUpdate()
    func testDelete()
}

extension RealmEntityTestProtocol {
    func runCRUDSpecs() {
        // Let's run all the specs for this entity.

        testCreate()
        testRead()
        testUpdate()
        testDelete()
    }
}
