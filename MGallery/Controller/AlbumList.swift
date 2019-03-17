//
//  AlbumList.swift
//  MGallery
//
//  Created by Mohammad on 12/23/1397 AP.
//  Copyright © 1397 mohammad. All rights reserved.
//

import UIKit

class AlbumList: UIViewController,UITableViewDelegate,UITableViewDataSource {

    fileprivate var cellLayout: MyCellLayout = .Mixture
    fileprivate var ChoosenAlbumID: String = "0"

    @IBOutlet var tableView: UITableView!
    
    private let cellID = "cell"
    private var albumArray = [Album]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var preventAnimation = Set<NSIndexPath>()
    let service = AlbumService()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(AlbumCell.self, forCellReuseIdentifier: cellID)
        tableView.estimatedRowHeight = 280
        tableView.rowHeight = UITableView.automaticDimension
        getAlbums(fromService: service)
    }


    override func viewWillAppear(_ animated: Bool) {
        let navController = parent as! UINavigationController
        if #available(iOS 11.0, *) {
            navController.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
    }
    private func getAlbums<S: Gettable2>(fromService service: S) where S.T == Array<Album?> {

        service.get { [weak self] (result) in
            switch result {
            case .Success(let album):
                var tempAlbum = [Album]()
                for album in album {
                    if let album = album {
                        tempAlbum.append(album)
                    }
                }
                self?.albumArray = tempAlbum
            case .Error(let error):
                print(error)
            }
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumArray.count;
    }



    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {


        //if !preventAnimation.contains(indexPath as NSIndexPath) {
            preventAnimation.insert(indexPath as NSIndexPath)
            TipInCellAnimator.animate(cell: cell)
        //}
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! AlbumCell
        let album = albumArray[indexPath.row]
        let albumViewModel = AlbumViewModel(model: album)
        cell.displayAlbumInCell(using: albumViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellLayout =  .Mixture
        ChoosenAlbumID = albumArray[indexPath.row].id



        performSegue(withIdentifier: "goToLayoutVC", sender: nil)
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? Gallery {
            vc.cellLayout = cellLayout
            vc.AlbumID=ChoosenAlbumID
        }
    }

}
