//
//  ImageDownload.swift
//  Imagine
//
//  Created by Federico on 4/19/20.
//  Copyright © 2020 FedericoPaliotta. All rights reserved.
//


import UIKit

class ImageDownload: Operation {
    
    var downloadHandler: ImageDownloadHandler?
    
    var imageUrl: URL?
    
    var progress: Progress?
    
    private var indexPath: IndexPath?
    
    override var isAsynchronous: Bool {
        return true
    }
    
    private var _isExecuting = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    override var isExecuting: Bool {
        get {
            return _isExecuting
        }
        set {
            _isExecuting = newValue
        }
    }
    
    private var _isFinished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isFinished: Bool {
        get {
            return _isFinished
        }
        set {
            _isFinished = newValue
        }
    }
    
    required init(imageUrl url: URL, indexPath path: IndexPath?) {
        imageUrl = url
        indexPath = path
    }
    
    override func main() {
        if isCancelled {
            isFinished = true
            return
        }
        isExecuting = true
        progress = downloadImage(from: imageUrl)
    }
    
    func downloadImage(from url: URL?) -> Progress? {
        guard let url = url else { return nil }
        let downloadTask = URLSession.shared.downloadTask(with: url)
        { location, response, error in
            if let localUrl = location, let data = try? Data(contentsOf: localUrl) {
                let image = UIImage(data: data)
                self.downloadHandler?(image, url, self.indexPath, error)
            }
            self.isFinished = true
            self.isExecuting = false
        }
        downloadTask.resume()
        return downloadTask.progress
    }
}
