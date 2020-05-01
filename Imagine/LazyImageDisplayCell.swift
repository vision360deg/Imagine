//
//  LazyImageDisplayCell.swift
//  Imagine
//
//  Created by Federico on 4/19/20.
//  Copyright © 2020 FedericoPaliotta. All rights reserved.
//

import UIKit

public protocol LazyImageDisplayCell: class {
    var lazyImageView: UIImageView { get }
    var loadProgress: Progress? { get set }
}

public extension LazyImageDisplayCell {
    var loadProgress: Progress? {
        get { return nil }
        set { }//fatalError("loadProgres not implemented")}
    }
}

public struct Imagine {

    public static func displayImage<LazyCell>(in cell: LazyCell,
                                              for indexPath: IndexPath,
                                              withUrl imageUrl: URL,
                                              size: CGSize)
        where LazyCell: LazyImageDisplayCell
    {
        let lazyImage = LazyImage(imageUrl: imageUrl, imageSize: size)
        let progress = ImageDownloader.shared.downloadImage(lazyImage, indexPath: indexPath)
        { image, url, path, error in
            guard url == lazyImage.sizedImageFetchUrl, indexPath == path else { return }
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
                    cell.lazyImageView.image = image
                    cell.lazyImageView.alpha = 1
                }, completion: nil)
            }
        }
        cell.loadProgress = progress
    }
    
    public static func slowImageDownloadPriority(for url: URL) {
        let lazyImage = LazyImage(imageUrl: url)
        return ImageDownloader.shared.slowImageDownloadPriority(for: lazyImage)
    }
}
