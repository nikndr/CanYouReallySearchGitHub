//
//  User+CoreDataProperties.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 16.11.2020.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var avatarURL: URL?
    @NSManaged public var login: String?
    @NSManaged public var repositories: NSOrderedSet?

}

// MARK: Generated accessors for repositories
extension User {

    @objc(insertObject:inRepositoriesAtIndex:)
    @NSManaged public func insertIntoRepositories(_ value: Repository, at idx: Int)

    @objc(removeObjectFromRepositoriesAtIndex:)
    @NSManaged public func removeFromRepositories(at idx: Int)

    @objc(insertRepositories:atIndexes:)
    @NSManaged public func insertIntoRepositories(_ values: [Repository], at indexes: NSIndexSet)

    @objc(removeRepositoriesAtIndexes:)
    @NSManaged public func removeFromRepositories(at indexes: NSIndexSet)

    @objc(replaceObjectInRepositoriesAtIndex:withObject:)
    @NSManaged public func replaceRepositories(at idx: Int, with value: Repository)

    @objc(replaceRepositoriesAtIndexes:withRepositories:)
    @NSManaged public func replaceRepositories(at indexes: NSIndexSet, with values: [Repository])

    @objc(addRepositoriesObject:)
    @NSManaged public func addToRepositories(_ value: Repository)

    @objc(removeRepositoriesObject:)
    @NSManaged public func removeFromRepositories(_ value: Repository)

    @objc(addRepositories:)
    @NSManaged public func addToRepositories(_ values: NSOrderedSet)

    @objc(removeRepositories:)
    @NSManaged public func removeFromRepositories(_ values: NSOrderedSet)

}

extension User : Identifiable {

}
