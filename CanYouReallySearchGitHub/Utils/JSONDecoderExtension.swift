//
//  JSONEncoderExtension.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 16.11.2020.
//
import UIKit

extension JSONDecoder {
    func withViewContext() -> Self {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return self }
        userInfo[CodingUserInfoKey.managedObjectContext] = context
        return self
    }
}
