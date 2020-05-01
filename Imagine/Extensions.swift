//
//  Extensions.swift
//  Imagine
//
//  Created by Federico on 4/18/20.
//  Copyright © 2020 FedericoPaliotta. All rights reserved.
//

import UIKit

extension UIImageView: ImagineCompatible {}

public extension ImagineWrapper where Base: UIImageView {
    
    @discardableResult
    func setImage(with url: URL) -> Progress? {
        let lazyImage = LazyImage(imageUrl: url)
        return ImageDownloader.shared.downloadImage(lazyImage, indexPath: nil)
        { image, imageUrl, _, error in
            guard let image = image, url == imageUrl, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.base.image = image
            }
        }
    }
}
