//
//  CoreDataManager.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 16.11.2020.
//

import CoreData
import UIKit

enum CoreDataManagerError: Error {
    case contextUnavailable
    case fetchRequestError(String)
    case deleteRequestError(String)
    case managedObjectInitFailed

    var localizedDescription: String {
        switch self {
        case .contextUnavailable:
            return "Could not retrieve NSManagedObjectContext while fetching"
        case let .fetchRequestError(description):
            return "Fetch request returned error: \(description)"
        case let .deleteRequestError(description):
            return "Delete request returned error: \(description)"
        case .managedObjectInitFailed:
            return "Failed to initialize Repository: NSManagedObject"
        }
    }
}

final class CoreDataManager: NSObject {
    private var viewContext: NSManagedObjectContext? {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return nil }
        return context
    }

    private var storeCoordinator: NSPersistentStoreCoordinator? {
        guard let coordinator = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.persistentStoreCoordinator else { return nil }
        return coordinator
    }


    func saveContext() {
        try? viewContext?.save()
    }

    func fetchRepositories(completion: @escaping (Result<[Repository], CoreDataManagerError>) -> Void) { // TODO: Error type
        guard let context = viewContext else {
            completion(.failure(.contextUnavailable))
            return
        }

        let fetchRequest = NSFetchRequest<Repository>(entityName: "Repository")
        let sortDescriptor = NSSortDescriptor(key: "stargazersCount", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let repositories = try context.fetch(fetchRequest)
            completion(.success(repositories))
        } catch {
            completion(.failure(.fetchRequestError(error.localizedDescription)))
        }
    }

    func saveRepositories(_ repositories: [RepositoryRemote]) throws {
        guard let context = viewContext else {
            throw CoreDataManagerError.contextUnavailable
        }

        for remoteRepository in repositories {
            guard let _ = Repository(from: remoteRepository, context: context) else {
                throw CoreDataManagerError.managedObjectInitFailed
            }
            try context.save()
        }
    }

    func deleteAllRepositories() throws {
        guard let context = viewContext else {
            throw CoreDataManagerError.contextUnavailable
        }
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Repository")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            throw CoreDataManagerError.deleteRequestError(error.localizedDescription)
        }
    }
}
