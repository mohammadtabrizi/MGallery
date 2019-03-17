//
//  PhotoViewModel.swift
//  MGallery
//
//  Created by Mohammad on 12/23/1397 AP.
//  Copyright © 1397 mohammad. All rights reserved.
//

import Foundation
import UIKit

struct PhotoViewModel {

    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String

    init(model: Photo) {
        self.albumId = model.albumId
        self.id = model.id
        self.title = model.title
        self.url = model.url
        self.thumbnailUrl = model.thumbnailUrl

        //We Can Do More staff to Data Here!!!!
    }
}
