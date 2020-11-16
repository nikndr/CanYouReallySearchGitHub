//
//  Repository+CoreDataProperties.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 16.11.2020.
//
//

import Foundation
import CoreData


extension Repository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repository> {
        return NSFetchRequest<Repository>(entityName: "Repository")
    }

    @NSManaged public var htmlURL: String?
    @NSManaged public var isVisited: Bool
    @NSManaged public var language: String?
    @NSManaged public var name: String?
    @NSManaged public var repositoryDescription: String?
    @NSManaged public var stargazersCount: Int16
    @NSManaged public var owner: User?

}

extension Repository : Identifiable {

}
