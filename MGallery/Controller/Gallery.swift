//
//  Gallery.swift
//  MGallery
//
//  Created by Mohammad on 12/23/1397 AP.
//  Copyright © 1397 mohammad. All rights reserved.
//

import UIKit
import WBCollectionViewLayout
import INSPhotoGallery

enum MyCellLayout: Int {
    case Two = 2
    case ThreeLeft = 3
    case ThreeRight = 4
    case Mixture = 5
}

class Gallery: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var AlbumID : String?
    var photos: [INSPhotoViewable] = []
    var cellLayout: MyCellLayout = .Mixture
    weak var customView: UILabel?
    @IBOutlet weak var collectionView: UICollectionView!
    private let cellID = "cell"
    private var photoArray = [Photo]() {
        didSet {
            for photo in photoArray {
                 var attributedTitle: NSAttributedString? {
                    return NSAttributedString(string: photo.title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                }
                let tmp:INSPhoto = INSPhoto(imageURL: URL(string: photo.url), thumbnailImage:  UIImage(named: "img_ph.jpg")!, attributedTitle: attributedTitle!)
                photos.append(tmp)
            }
            self.collectionView.reloadData()
        }
    }


    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Gallery"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        } else {
            // Fallback on earlier versions
        }
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "gridLayout"), style: .done, target: self, action: #selector(Gallery.layoutChange))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem


        let layout = WBGridViewLayout()
        layout.delegate = self
        collectionView.setCollectionViewLayout(layout, animated: true)

        let Url = "https://jsonplaceholder.typicode.com/photos?albumId="+AlbumID!
        let service =  PhotoService(string: Url)
        getPhoto(fromService: service)
    }


    @objc func layoutChange()
    {
        switch cellLayout {
        case .Two:
            cellLayout = .Mixture
            break
        case .Mixture:
            cellLayout = .Two
            break
        default:
            cellLayout = .Mixture
        }
        self.collectionView.reloadData()
    }


    private func getPhoto<S: Gettable>(fromService service: S) where S.T == Array<Photo?> {
        service.get { [weak self] (result) in
            switch result {
            case .Success(let photo):
                var tempPhoto = [Photo]()
                for photo in photo {
                    if let photo = photo {
                        tempPhoto.append(photo)
                    }
                }
                self?.photoArray = tempPhoto
            //dump(self.movies)
            case .Error(let error):
                print(error)
            }
        }
    }


    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? PhotoCell
        let photo = photoArray[indexPath.row]
        let photoViewModel = PhotoViewModel(model: photo)
        cell?.displayPhotoInCell(using: photoViewModel)
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotoCell
        let currentPhoto = photos[indexPath.row]
        let galleryPreview = INSPhotosViewController(photos: photos, initialPhoto: currentPhoto, referenceView: cell)
        present(galleryPreview, animated: true, completion: nil)
    }

    func colectionView(_ collectionView: UICollectionView, sizeOfItemInRow row: Int) -> CGSize? {
        return nil
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
        }
    }
}


    // MARK: - WBGridViewLayoutDelegate
    extension Gallery: WBGridViewLayoutDelegate {
    func colectionView(_ collectionView: UICollectionView, numberOfItemsInRow row: Int) -> CellLayout {
        switch cellLayout {
        case .Two: return .Two
        case .ThreeLeft: return .ThreeLeft
        case .ThreeRight: return .ThreeRight
        case .Mixture:
            if row % 4 == 1 || row % 4 == 2 {
                if row % 2 == 0 {
                    return .ThreeRight
                }
                return .ThreeLeft
            }
        }
        return CellLayout.Two
    }
}


