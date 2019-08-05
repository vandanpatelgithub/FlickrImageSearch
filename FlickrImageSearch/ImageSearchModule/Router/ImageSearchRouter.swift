//
//  ImageSearchRouter.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 8/4/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import UIKit

protocol ImageSearchRoutable: class {
}

class ImageSearchRouter {
    let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
}

extension ImageSearchRouter: ImageSearchRoutable {
}
