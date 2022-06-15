//
//  LoadImage.swift
//  CanYouReallySearchGitHub
//
//  Created by Nikandr Marhal on 15.11.2020.
//

import UIKit

func loadImage(from url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        guard
            let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil
        else {
            return
        }
        completion(UIImage(data: data))
    }
    .resume()
}
