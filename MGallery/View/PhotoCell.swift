//
//  PhotoCell.swift
//  MGallery
//
//  Created by Mohammad on 12/23/1397 AP.
//  Copyright © 1397 mohammad. All rights reserved.
//

import Foundation
import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var photo: UIImageView!

    func displayPhotoInCell(using viewModel: PhotoViewModel) {
        photo.loadImageUsingCacheWithURLString(viewModel.thumbnailUrl, placeHolder: UIImage(named: "img_ph.jpg")) { (bool) in
            //perform actions if needed
        }
    }
}
