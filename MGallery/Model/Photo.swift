//
//  Photo.swift
//  MGallery
//
//  Created by Mohammad on 12/23/1397 AP.
//  Copyright © 1397 mohammad. All rights reserved.
//

import Foundation
import UIKit

struct Photo {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

extension Photo {
    struct Key  {
        static let albumId = "albumId"
        static let id = "id"
        static let title = "title"
        static let url = "url"
        static let thumbnailUrl = "thumbnailUrl"
    }

    init?(json: [String: AnyObject]) {
        guard let albumId = json[Key.albumId] as? Int,
            let id = json[Key.id] as? Int,
            let title = json[Key.title] as? String,
            let url = json[Key.url] as? String,
            let thumbnailUrl = json[Key.thumbnailUrl] as? String

            else {
                return nil
        }

        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
    }
}
