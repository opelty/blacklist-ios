//
//  RealmManager.swift
//  blacklistTests
//
//  Created by Mateo Olaya Bernal on 2/3/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import XCTest
import RealmSwift
@testable import blacklist

class TestObject: Object {
    @objc dynamic var r_id: String = UUID().uuidString
    @objc dynamic var r_name: String?

    override class func primaryKey() -> String? {
        return "r_id"
    }
}

class RealmManager: XCTestCase {
    private var object: TestObject?

    override func setUp() {
        super.setUp()

        object = TestObject()
        object?.r_name = "This is a test"

        let unmutableObject1 = TestObject()
        unmutableObject1.r_name = "This is a test #1"

        let unmutableObject2 = TestObject()
        unmutableObject2.r_name = "This is a test #2"

        blacklist.RealmManager.shared.add(objects: object!, unmutableObject1, unmutableObject2)
    }

    override func tearDown() {
        object = nil
        blacklist.RealmManager.shared.removeContext()

        super.tearDown()
    }

    // MARK: - CRUD Tests

    func testFetch() {
        // Test `.all` method, should return 3 elements
        XCTAssertGreaterThanOrEqual(blacklist.RealmManager.shared.all(for: TestObject.self).count, 3)

        // Test `.find` method, should return 1 element equals to `self.object`
        let objectTested = blacklist.RealmManager.shared.find(for: TestObject.self, id: object!.r_id)!

        XCTAssertEqual(objectTested.r_id, object!.r_id)
        XCTAssertEqual(objectTested.r_name, object!.r_name)

        // Test `.all` method with predicate, should return 1 element equals to `unmutableObject2`
        let objectsTested = blacklist.RealmManager.shared.all(
            for: TestObject.self,
            predicate: "r_name == 'This is a test #2'"
        )

        XCTAssertGreaterThanOrEqual(objectsTested.count, 1)
        XCTAssertEqual(objectsTested[0].r_name, "This is a test #2")
    }

    func testUpdate() {
        // Let's modify the testObject
        blacklist.RealmManager.shared.update(object: object!) { () -> [String: Any] in
            return [
                "r_name": "MODIFIED_VALUE"
            ]
        }

        if let modified = blacklist.RealmManager.shared.find(for: TestObject.self, id: object!.r_id) {
            XCTAssertEqual(modified.r_name, "MODIFIED_VALUE")
        } else {
            XCTFail()
        }
    }

    func testDelete() {
        let deleteObject = TestObject()
        deleteObject.r_name = "This is a temporal test"

        let lastId = deleteObject.r_id

        // Add object to realm
        blacklist.RealmManager.shared.add(object: deleteObject)
        XCTAssertNotNil(blacklist.RealmManager.shared.find(for: TestObject.self, id: deleteObject.r_id))

        blacklist.RealmManager.shared.delete(object: deleteObject)
        XCTAssertNil(blacklist.RealmManager.shared.find(for: TestObject.self, id: lastId))
    }

    func testClear() {
        blacklist.RealmManager.shared.clear()

        XCTAssertEqual(blacklist.RealmManager.shared.all(for: TestObject.self).count, 0)
    }

    func testMigrationSchemaVersion() {
        XCTAssertEqual(blacklist.RealmManager.shared.currentSchemaVersion, 1)
    }
}
