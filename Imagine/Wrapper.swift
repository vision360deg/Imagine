//
//  Wrapper.swift
//  Imagine
//
//  Created by Federico on 4/19/20.
//  Copyright © 2020 FedericoPaliotta. All rights reserved.
//

import Foundation

public class ImagineWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol ImagineCompatible: AnyObject { }

public extension ImagineCompatible {
    var img: ImagineWrapper<Self> {
        get { return ImagineWrapper(self) }
        set { }
    }
}
