//
//  AlbumService.swift
//  MGallery
//
//  Created by Mohammad on 12/23/1397 AP.
//  Copyright © 1397 mohammad. All rights reserved.
//

import UIKit
import Foundation

//2 conform to protocol
struct AlbumService: Gettable2 {

    //3
    let endpoint: String = "https://jsonplaceholder.typicode.com/albums"
    let downloader = JSONDownloader()
    //the associated type is inferred by <[Movie?]>
    typealias CurrentWeatherCompletionHandler = (Result<[Album?]>) -> ()

    //4 protocol required function
    func get(completion: @escaping CurrentWeatherCompletionHandler) {
        guard let url = URL(string: self.endpoint) else {
            completion(.Error(.invalidURL))
            return
        }
        //5 using the JSONDownloader function
        let request = URLRequest(url: url)
        let task = downloader.jsonTask(with: request) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .Error(let error):
                    completion(.Error(error))
                    return
                case .Success(let json):
                    //6 parsing the Json response
                    var AlbumList = [Album]()
                    for dict in json {
                        let id = dict[Album.Key.id] as? Int
                        let title = dict[Album.Key.title] as? String
                        let object = Album(id: String(id!),title: title!)
                        AlbumList.append(object)
                    }
                    if(AlbumList.isEmpty){
                        completion(.Error(.jsonParsingFailure))
                        return
                    }
                    //7 maping the array and create Movie objects
                    //let albumArray = ""
                    completion(.Success(AlbumList))
                }
            }
        }
        task.resume()
    }
}

//1 uisng associatedType in protocol
protocol Gettable2 {
    associatedtype T
    func get(completion: @escaping (Result<T>) -> Void)
}
