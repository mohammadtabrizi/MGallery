//
//  AlbumViewModel.swift
//  MGallery
//
//  Created by Mohammad on 12/23/1397 AP.
//  Copyright © 1397 mohammad. All rights reserved.
//

import UIKit

struct AlbumViewModel {

    let id : String
    let title: String

    init(model: Album) {
        self.id = model.id
        self.title = model.title.uppercased()


        //We Can Do More staff to Data Here!!!!
    }
}
