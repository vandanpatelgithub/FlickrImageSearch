//
//  ImageSearchBuilder.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 7/29/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import UIKit

class ImageSearchBuilder {
    static func buildImageSearchView() -> UINavigationController? {
        let storyboard = UIStoryboard(name: "ImageSearch", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ImageSearchVC") as? ImageSearchViewController else {
            return nil
        }
        let navVC = UINavigationController(rootViewController: vc)
        let interactor = ImageSearchInteractor(networkManager: NetworkManager())
        let presenter = ImageSearchPresenter(view: vc, interactor: interactor)
        let router = ImageSearchRouter(navVC: navVC)
        presenter.router = router
        vc.presenter = presenter
        interactor.presenter = presenter
        return navVC
    }
}
