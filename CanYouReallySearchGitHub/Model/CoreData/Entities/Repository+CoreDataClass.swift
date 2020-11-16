//
//  Repository+CoreDataClass.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 16.11.2020.
//
//

import CoreData
import Foundation

public class Repository: NSManagedObject {
    
    private override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    init?(from remoteEntity: RepositoryRemote, context: NSManagedObjectContext) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Repository", in: context) else { return nil }
        super.init(entity: entityDescription, insertInto: context)

        name = remoteEntity.name
        htmlURL = remoteEntity.htmlURL
        repositoryDescription = remoteEntity.repositoryDescription
        language = remoteEntity.language
        stargazersCount = Int32(remoteEntity.stargazersCount ?? 0)
        isVisited = false

        login = remoteEntity.owner.login
        avatarURL = remoteEntity.owner.avatarURL
    }
}
