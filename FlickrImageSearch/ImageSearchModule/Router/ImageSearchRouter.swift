//
//  ImageSearchRouter.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 8/4/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import UIKit

protocol ImageSearchRoutable {
    func navigateToFullImageVC(withImage image: UIImage)
}

class ImageSearchRouter {
    let navVC: UINavigationController
    
    init(navVC: UINavigationController) {
        self.navVC = navVC
    }
}

extension ImageSearchRouter: ImageSearchRoutable {
    func navigateToFullImageVC(withImage image: UIImage) {
        let storyboard = UIStoryboard(name: "ImageSearch", bundle: nil)
        let fullImageVC = storyboard.instantiateViewController(withIdentifier: "FullImageVC") as! FullImageViewController
        fullImageVC.imageData = image.pngData()
        navVC.present(fullImageVC, animated: true, completion: nil)
    }
}
