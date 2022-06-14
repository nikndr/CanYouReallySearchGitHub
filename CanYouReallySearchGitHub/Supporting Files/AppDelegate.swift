//
//  AppDelegate.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 11.11.2020.
//

import CoreData
import UIKit

import FirebaseCore
import FirebaseCrashlytics
import FirebasePerformance

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CanYouReallySearchGitHub")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - UIApplicationDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        sendUnsentReports()
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    // MARK: - Core Data Saving support

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    private func sendUnsentReports() {
        Crashlytics.crashlytics().checkForUnsentReports { unsentReportsPresent in
            if unsentReportsPresent {
                Crashlytics.crashlytics().sendUnsentReports()
            }
        }
    }
}
