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

    public var currentSchemaVersion: UInt64 {
        let buildVersionString = Bundle.main.infoDictionary!["CFBundleVersion"] as! String

        guard let schemaVersion = UInt64(buildVersionString) else { fatalError("Invalid schema version.") }
        return schemaVersion
    }

    public var realmRootFolderURL: URL {
        guard let documentsPath = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
            true).first else {

                fatalError("Realm's document directory context not found.")
        }

        return URL(fileURLWithPath: documentsPath).appendingPathComponent(Constants.Realm.rootDirectory)
    }

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

    public func removeContext() {
        self.deleteOldContext()
        self.configure()
    }

    // MARK: - CRUD

    public func add(object: Object, update: Bool = true) {
        if context.isInWriteTransaction {
            context.add(object, update: update)
        } else {
            try! context.write {
                context.add(object, update: update)
            }
        }
    }

    public func add(objects: Object..., update: Bool = true) {
        for object in objects {
            add(object: object, update: update)
        }
    }

    public func all<M: Object>(for type: M.Type, predicate: String? = nil) -> [M] {
        let objects = context.objects(type)

        if let predicate = predicate {
            return Array(objects.filter(predicate))
        }

        return Array(objects)
    }

    public func find<M: Object>(for type: M.Type, id: String) -> M? {
        return context.object(ofType: type, forPrimaryKey: id)
    }

    public func update<M: Object>(object: M, clousure: (M) -> Void) {
        try! context.write {
            clousure(object)
        }
    }

    public func delete(object: Object) {
        try! context.write {
            context.delete(object)
        }
    }

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
