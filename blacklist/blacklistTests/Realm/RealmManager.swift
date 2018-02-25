//
//  RealmManager.swift
//  blacklistTests
//
//  Created by Mateo Olaya Bernal on 2/3/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import XCTest
import RealmSwift
import Quick
import Nimble

@testable import blacklist

// MARK: - Dummy Realm's Objects

class DummyCreationTestObject: Object {
    @objc dynamic var r_id: String = UUID().uuidString

    override class func primaryKey() -> String? {
        return "r_id"
    }
}

class DummyTestObject: Object {
    @objc dynamic var r_id: String = UUID().uuidString
    @objc dynamic var r_name: String?

    override class func primaryKey() -> String? {
        return "r_id"
    }
}

// MARK: - Specs

class RealmHandlerSpecs: QuickSpec, RealmEntityTestProtocol {
    override func spec() {
        runCRUDSpecs()
    }

    // MARK: - CRUD spectations

    func testCreate() {
        describe("RealmManager") {
            beforeEach {
                blacklist.RealmManager.shared.clear()
            }

            it("should be able to create a new entity table") {
                let dummy = DummyCreationTestObject()
                blacklist.RealmManager.shared.add(object: dummy)

                let objects = blacklist.RealmManager.shared.all(for: DummyCreationTestObject.self)

                // Specs
                expect(objects.count).to(equal(1))
                expect(objects.first).toNot(beNil())
                expect(objects.first!.r_id).to(equal(dummy.r_id))
            }

            it("should be able to add new object to existing entity table") {
                let dummyItem1 = DummyTestObject()
                let dummyItem2 = DummyTestObject()
                let dummyItem3 = DummyTestObject()

                let dummies = [dummyItem1, dummyItem2, dummyItem3]

                // Add them to Realm
                blacklist.RealmManager.shared.add(objects: dummyItem1, dummyItem2, dummyItem3)

                let objects = blacklist.RealmManager.shared.all(for: DummyTestObject.self)

                // Specs
                expect(objects.count).to(equal(3))

                for i in 0..<dummies.count {
                    let dummy = dummies[i]
                    let realm = objects[i]

                    expect(realm.r_id).to(equal(dummy.r_id))
                }
            }
        }
    }

    func testRead() {
        describe("RealmManager") {
            beforeEach {
                // Let's add an dummy object to Realm
                let dummy = DummyTestObject()
                dummy.r_name = "DUMMY_TEST_OBJECT"

                blacklist.RealmManager.shared.add(object: dummy)
            }

            afterEach {
                // Let's remove the dummy object from Realm
                blacklist.RealmManager.shared.clear()
            }

            context("when it has at least one entity") {
                it("should be able to read and return the entity") {
                    let objects = blacklist.RealmManager.shared.all(for: DummyTestObject.self)

                    // Specs
                    expect(objects.count).to(equal(1))
                    expect(objects.first).toNot(beNil())
                    expect(objects.first!.r_name).to(equal("DUMMY_TEST_OBJECT"))
                }

                it("should be able to read and return an onject using a predicate") {
                    let dummy = DummyTestObject()
                    dummy.r_name = "DUMMY_TEST_OBJECT_FOR_PREDICATE"

                    // Add dummy to Realm
                    blacklist.RealmManager.shared.add(object: dummy)

                    let objects = blacklist.RealmManager.shared.all(
                        for: DummyTestObject.self,
                        predicate: "r_name = 'DUMMY_TEST_OBJECT_FOR_PREDICATE'"
                    )

                    // Specs
                    expect(objects.count).to(equal(1))
                    expect(objects.first).toNot(beNil())
                    expect(objects.first!.r_id).to(equal(dummy.r_id))
                }
            }
        }
    }

    func testUpdate() {
        describe("RealmManager") {
            beforeEach {
                // Let's add an dummy object to Realm
                let dummy = DummyTestObject()
                dummy.r_name = "DUMMY_TEST_UPDATE_OBJECT"

                blacklist.RealmManager.shared.add(object: dummy)
            }

            afterEach {
                // Let's remove the dummy object from Realm
                blacklist.RealmManager.shared.clear()
            }

            it("should be able to modify and existing object without have to create a new one") {
                let objects = blacklist.RealmManager.shared.all(for: DummyTestObject.self)

                // Let's check the dummy object stored before run the specs for this context.
                expect(objects.count).to(equal(1))
                expect(objects.first).toNot(beNil())
                expect(objects.first!.r_name).to(equal("DUMMY_TEST_UPDATE_OBJECT"))

                blacklist.RealmManager.shared.update(object: objects.first!) { (model) in
                    model.r_name = "DUMMY_UPDATED_OBJECT"
                }

                let updatedObjects = blacklist.RealmManager.shared.all(for: DummyTestObject.self)

                // Specs
                expect(updatedObjects.count).to(equal(1))
                expect(updatedObjects.first).toNot(beNil())
                expect(updatedObjects.first!.r_name).to(equal("DUMMY_UPDATED_OBJECT"))
            }
        }
    }

    func testDelete() {
        describe("RealmManager") {
            context("when it has entities stored") {
                beforeEach {
                    // Lets add some dummy data
                    let dummyItem1 = DummyTestObject()
                    dummyItem1.r_name = "TEST_1"
                    let dummyItem2 = DummyTestObject()
                    dummyItem2.r_name = "TEST_2"
                    let dummyItem3 = DummyTestObject()
                    dummyItem3.r_name = "TEST_3"

                    // Add them to Realm
                    blacklist.RealmManager.shared.add(objects: dummyItem1, dummyItem2, dummyItem3)
                }

                afterEach {
                    // Let's remove the dummy object from Realm
                    blacklist.RealmManager.shared.clear()
                }

                it("should be able to delete a specific entity") {
                    var objectsThatShouldBe = 3

                    let objects = blacklist.RealmManager.shared.all(for: DummyTestObject.self)
                    expect(objects.count).to(equal(objectsThatShouldBe))

                    for object in objects {
                        blacklist.RealmManager.shared.delete(object: object)
                        objectsThatShouldBe -= 1

                        let newObjects = blacklist.RealmManager.shared.all(for: DummyTestObject.self)

                        // Specs
                        expect(object.r_id).to(raiseException())
                        expect(newObjects.count).to(equal(objectsThatShouldBe))
                    }
                }

                it("should be able to delete all entities stored") {
                    blacklist.RealmManager.shared.clear()
                    let objects = blacklist.RealmManager.shared.all(for: DummyTestObject.self)

                    expect(objects).to(beNil() || beEmpty())
                }
            }
        }
    }
}
