//
//  RealmManager.swift
//  blacklist
//
//  Created by Mateo Olaya Bernal on 2/3/18.
//  Copyright © 2018 Opelty's Open Source Projects. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmManager {
    static let shared = RealmManager()
    fileprivate var context: Realm!

    /**
     * Gets the schema version for the current context
     */
    public var currentSchemaVersion: UInt64 {
        let buildVersionString = Bundle.main.infoDictionary!["CFBundleVersion"] as! String

        guard let schemaVersion = UInt64(buildVersionString) else { fatalError("Invalid schema version.") }
        return schemaVersion
    }

    /**
     * Gets the Realm's root folder URL for the current context
     */
    public var realmRootFolderURL: URL {
        guard let documentsPath = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
            true).first else {

                fatalError("Realm's document directory context not found.")
        }

        return URL(fileURLWithPath: documentsPath).appendingPathComponent(Constants.Realm.rootDirectory)
    }

    /**
     * Gets the Realm's database file URL for the current context
     */
    public var fileURL: URL {
        return realmRootFolderURL.appendingPathComponent(Constants.Realm.databaseName)
    }

    private init() {
        configure()
    }

    private func configure() {
        do {
            var config = Realm.Configuration()
            config.fileURL = fileURL
            config.schemaVersion = currentSchemaVersion
            config.deleteRealmIfMigrationNeeded = true
            config.migrationBlock = { [unowned self] (migration, oldSchemaVersion) in
                if self.currentSchemaVersion > oldSchemaVersion {
                    self.performMigration(migration: migration, oldSchemaVersion: oldSchemaVersion)
                }
            }

            Realm.Configuration.defaultConfiguration = config

            try self.createDirectories()
            self.context = try Realm()
        } catch {
            deleteOldContext()

            fatalError("Somethig went wrong with Realm, the instance couldn't be initializated.")
        }
    }

    /**
     * Removes all Realm's file used in the current context.
     *
     * - returns:
     *   Void
     */
    public func removeContext() {
        self.deleteOldContext()
        self.configure()
    }

    // MARK: - CRUD

    /**
     * Adds an object to the database
     *
     * - parameters:
     *   - object: Realm's object that will be stored
     *   - update: Updates an existing object if have the same primaryKey (true)
     *             or creates a new one stored object (false)
     * - returns:
     *   void
     */
    public func add(object: Object, update: Bool = true) {
        if context.isInWriteTransaction {
            context.add(object, update: update)
        } else {
            try! context.write {
                context.add(object, update: update)
            }
        }
    }

    /**
     * Adds several objects to the database
     *
     * - parameters:
     *   - objects: Realm's objects that will be stored
     *   - update: Updates the existing objects if have the same primaryKey (true)
     *             or create those new objects (false)
     * - returns:
     *   void
     */
    public func add(objects: Object..., update: Bool = true) {
        for object in objects {
            add(object: object, update: update)
        }
    }

    /**
     * Gets all objects for the following type
     *
     * - parameters:
     *   - type: Realm's object type that will be searched
     *   - predicate: The predicate for the search, see Realm's documentation
     * - returns:
     *   Set of Realm's objects that satisfy the predicate or all stored items for
     *   the defined type if the predicate is defined as nil.
     */
    public func all<M: Object>(for type: M.Type, predicate: String? = nil) -> [M] {
        let objects = context.objects(type)

        if let predicate = predicate {
            return Array(objects.filter(predicate))
        }

        return Array(objects)
    }

    /**
     * Gets the object for the following type that has the id field as primaryKey
     *
     * - parameters:
     *   - type: Realm's object type that will be searched
     *   - id: The primaryKey that will be searched
     * - returns:
     *   A Realm's object that has the id field as primaryKey or nil if none satisfy the predicate
     */
    public func find<M: Object>(for type: M.Type, id: String) -> M? {
        return context.object(ofType: type, forPrimaryKey: id)
    }

    /**
     * Updates the object provided inside of the write transaction.
     *
     * - parameters:
     *   - object: Realm's object that should be updated
     *   - closure: Closure to make changes, all changes in the M (model) will be stored.
     *     - M: The reference to the provided Realm's object that will be changed.
     * - returns:
     *   Void
     */
    public func update<M: Object>(object: M, closure: (M) -> Void) {
        try! context.write {
           closure(object)
        }
    }

    /**
     * Deletes the Realm's object provided.
     *
     * - parameters:
     *   - object: Realm's object type that will be deleted.
     * - returns:
     *   Void
     */
    public func delete(object: Object) {
        try! context.write {
            context.delete(object)
        }
    }

    /**
     * Deletes all Realm's objects stored in the current context.
     *
     * - returns:
     *   Void
     */
    public func clear() {
        try! context.write {
            context.deleteAll()
        }
    }

    // MARK: - Migration Delegate

    private func performMigration(migration: Migration, oldSchemaVersion: UInt64) {
        // Adds here the behavior when the Realm should perform a migration...
    }

    // MARK: - FileManager helpers

    fileprivate func deleteOldContext() {
        let path = realmRootFolderURL

        let realm = path.appendingPathComponent(Constants.Realm.databaseName).path
        let lockFile = "\(realm).lock"
        let managmentFolder = "\(realm).management"

        try! FileManager.default.remove(paths: realm, lockFile, managmentFolder)
    }

    fileprivate func createDirectories() throws {
        try FileManager.default.createDirectory(
            at: realmRootFolderURL,
            withIntermediateDirectories: true,
            attributes: nil
        )
    }
}
