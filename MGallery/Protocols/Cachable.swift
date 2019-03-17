//
//  Cachable.swift
//  MGallery
//
//  Created by Mohammad on 12/23/1397 AP.
//  Copyright © 1397 mohammad. All rights reserved.
//

import Foundation
import UIKit

//Create the protocol
protocol Cachable {}

//creating a imageCache private instance
private  let imageCache = NSCache<NSString, UIImage>()

//UIImageview conforms to Cachable
extension UIImageView: Cachable {}

//creating a protocol extension to add optional function implementations,
extension Cachable where Self: UIImageView {

    //5 creating the function
    typealias SuccessCompletion = (Bool) -> ()
    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?, completion: @escaping SuccessCompletion) {

        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            DispatchQueue.main.async {
                self.image = cachedImage
                completion(true)
            }
            return
        }
        self.image = placeHolder

        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in

                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                if httpResponse.statusCode == 200 {

                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            DispatchQueue.main.async {
                                self.image = downloadedImage
                                completion(true)
                            }
                        }
                    }
                } else {
                    self.image = placeHolder
                }
            }).resume()
        } else {
            self.image = placeHolder
        }
    }
}
