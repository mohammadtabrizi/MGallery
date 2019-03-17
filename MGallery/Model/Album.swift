//
//  Album.swift
//  MGallery
//
//  Created by Mohammad on 12/23/1397 AP.
//  Copyright © 1397 mohammad. All rights reserved.
//

import Foundation
import UIKit

struct Album {
    let id : String
    let title: String
}

extension Album {

    struct Key  {
        static let id = "id"
        static let title = "title"
    }

    //failable initializer
    init?(json: [String: AnyObject]) {

        guard let id = json[Key.id] as? String,
            let title = json[Key.title] as? String
            else {
                return nil
        }
        self.title = title
        self.id = id
    }
}
