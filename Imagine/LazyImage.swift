//
//  LazyImage.swift
//  Imagine
//
//  Created by Federico on 4/19/20.
//  Copyright © 2020 FedericoPaliotta. All rights reserved.
//

import UIKit

public struct LazyImage {
    
    public let imageUrl: URL
    public let imageSize: CGSize?
    public let renderScreenFactor: CGFloat
    
    public init(imageUrl: URL,
                imageSize: CGSize? = nil,
                renderScreenFactor: CGFloat = 3) {
        self.imageUrl = imageUrl
        self.imageSize = imageSize
        self.renderScreenFactor = renderScreenFactor
    }
    
    public var sizedImageFetchUrl: URL? {
        guard let size = imageSize else {
            return imageUrl
        }
        let width = size.width * renderScreenFactor
        let result = URL(string: "https://images1-focus-opensocial.googleusercontent.com/gadgets/proxy?container=focus&url=\(imageUrl.absoluteString)&resize_w=\(width)")!
        return result
    }
}
