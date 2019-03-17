//
//  PhotoService.swift
//  MGallery
//
//  Created by Mohammad on 12/23/1397 AP.
//  Copyright © 1397 mohammad. All rights reserved.
//

import Foundation
import UIKit

//2 conform to protocol
struct PhotoService: Gettable {


    var endpoint: String = ""
    init(string:String) {
         endpoint = string
    }

        let downloader = JSONDownloader()
 
    //3


    //the associated type is inferred by <[Photo?]>
    typealias CurrentWeatherCompletionHandler = (Result<[Photo?]>) -> ()

    //4 protocol required function
    func get(completion: @escaping CurrentWeatherCompletionHandler) {

        guard let url = URL(string: self.endpoint) else {
            completion(.Error(.invalidURL))
            return
        }
        //5 using the JSONDownloader function
        let request = URLRequest(url: url)
     //   request.httpMethod = "GET"
        let task = downloader.jsonTask(with: request) { (result) in

            DispatchQueue.main.async {
                switch result {
                case .Error(let error):
                    completion(.Error(error))
                    return
                case .Success(let json):
                    var PhotoList = [Photo]()
                    for dict in json {
                        let albumId = dict[Photo.Key.albumId] as? Int
                        let id = dict[Photo.Key.id] as? Int
                        let title = dict[Photo.Key.title] as? String
                        let url = dict[Photo.Key.url] as? String
                        let thumbnailUrl = dict[Photo.Key.thumbnailUrl] as? String

                        let object = Photo(albumId: albumId!,id: id!,title: title!,url:url!,thumbnailUrl:thumbnailUrl!)
                     
                        PhotoList.append(object)
                    }
                    if(PhotoList.isEmpty){
                        completion(.Error(.jsonParsingFailure))
                        return
                    }
                    //7 maping the array and create Movie objects
                    //let albumArray = ""
                    completion(.Success(PhotoList))
                }
            }
        }
        task.resume()
    }
}

//1 uisng associatedType in protocol
protocol Gettable {
    associatedtype T
    
    func get(completion: @escaping (Result<T>) -> Void)
}
