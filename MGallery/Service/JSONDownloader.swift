//
//  JSONDownloader.swift
//  MGallery
//
//  Created by Mohammad on 12/23/1397 AP.
//  Copyright © 1397 mohammad. All rights reserved.
//

import Foundation

struct JSONDownloader {

    //creating the session
    let session: URLSession

    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }

    init() {
        self.init(configuration: .default)

    }

    typealias JSON = [AnyObject]
    typealias JSONTaskCompletionHandler = (Result<JSON>) -> ()
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {

        let task = session.dataTask(with: request) { (data, response, error) in

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.Error(.requestFailed))
                return
            }

            if httpResponse.statusCode == 200 {

                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [AnyObject] {
                            DispatchQueue.main.async {
                                completion(.Success(json))
                            }
                        }
                    } catch {
                        completion(.Error(.jsonConversionFailure))
                    }
                } else {
                    completion(.Error(.invalidData))
                }
            } else {
                completion(.Error(.responseUnsuccessful))
                print("\(String(describing: error))")
            }
        }
        return task
    }
}

enum Result <T>{
    case Success(T)
    case Error(jsonplaceholderApiError)
}

enum jsonplaceholderApiError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case invalidURL
    case jsonParsingFailure
}
