//
//  ImageLibrary.swift
//  MrozShopify2019
//
//  Created by Mark Mroz on 2019-01-13.
//  Copyright © 2019 Mark Mroz. All rights reserved.
//

import Foundation
import UIKit

enum ImageLibraryError: Error {
    /// An error occurred retrieving the image from the network.
    case networkError(Error)
    /// The retrieved image data could not be deserialized.
    case imageFormatInvalid
}

public final class ImageLibrary {
    
    // MARK: - Public Types
    
    public typealias CompletionHandler = (UIImage?, Error?) -> ()
    
    // MARK: - Private Properties
    
    /// Dispatch queue for synchronizing access to caches and request lists.
    private let workQueue = OperationQueue()
    
    /// Image data retrieved from the specified URLs. Work queue access only.
    private let imageDataCache = NSCache<NSURL, UIImage>()
    
    /// Map from inflight URLs to the associated completion handlers. Work queue access only.
    private var inflightRequests = [URL : Array<CompletionHandler>]()
    
    // MARK: - Public Methods
    
    /// Asynchronously retrieves an image from a URL resource.
    /// - Note: Thread-safe.
    /// - Parameters:
    ///   - url: The URL of the image resource to retrieve.
    ///   - completionHandler:
    ///     The block to invoke on the main queue with an image or failure reason.
    ///     The completion handler is always invoked on the main queue.
    ///     If the request completes successfully, the data parameter of the completion handler block
    ///     contains the image, and the error parameter is nil.
    ///     If the request fails, the data parameter is nil and the error parameter contain
    ///     information about the failure.
    public func image(at url: URL, completionHandler: @escaping CompletionHandler) {
        self.workQueue.addOperation {
            if let existingImage = self.imageDataCache.object(forKey: url as NSURL) {
                OperationQueue.main.addOperation {
                    completionHandler(existingImage, nil)
                }
            } else {
                self.enqueueRequest(for: url, completionHandler: completionHandler)
            }
        }
    }
    
    // MARK: - Private Methods - Work Queue Access Only
    
    /// Enqueues a request for an image with the specified url and completion handler.
    /// - Note: Must be executed on the work queue.
    private func enqueueRequest(for url: URL, completionHandler: @escaping CompletionHandler) {
        precondition(OperationQueue.current == self.workQueue)
        
        // Add the completion handler to the list of inflight requests for this URL.
        let existingRequestsForUrl = self.inflightRequests[url, default: []]
        let newRequestsForUrl: Array<CompletionHandler> = {
            var newValue = existingRequestsForUrl
            newValue.append(completionHandler)
            return newValue
        }()
        
        self.inflightRequests.updateValue(newRequestsForUrl, forKey: url)
        
        // Create a task to fetch the image data at the URL and return to the work queue when complete.
        if existingRequestsForUrl.isEmpty {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                self.workQueue.addOperation {
                    self.completeInflightRequests(for: url, data: data, error: error)
                }
            }).resume()
        }
    }
    
    /// Deserializes the image data, if available, and completes all inflight requests for the URL.
    /// - Note: Must be executed on the work queue.
    private func completeInflightRequests(for url: URL, data: Data?, error: Error?) {
        precondition(OperationQueue.current == self.workQueue)
        
        // Take all the inflight requests for the URL out of the list.
        let requestsToComplete = self.inflightRequests.removeValue(forKey: url) ?? []
        
        // A network error occurred accessing the image.
        if let networkError = error {
            OperationQueue.main.addOperation {
                requestsToComplete.forEach({ completionHandler in
                    completionHandler(nil, ImageLibraryError.networkError(networkError))
                })
            }
            return
        }
        
        // Attempt to deserialize the image.
        if let imageData = data {
            if let image = UIImage(data: imageData) {
                self.imageDataCache.setObject(image, forKey: url as NSURL, cost: imageData.count)
                OperationQueue.main.addOperation {
                    requestsToComplete.forEach({ completionHandler in
                        completionHandler(image, nil)
                    })
                }
                return
            }
        }
        
        // The image could not be deserialized.
        OperationQueue.main.addOperation {
            requestsToComplete.forEach({ completionHandler in
                completionHandler(nil, ImageLibraryError.imageFormatInvalid)
            })
        }
    }
    
}
