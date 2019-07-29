//
//  ViewController.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 7/27/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager().getPhotos(forSearchText: "Food", andPageNo: 1) { (response, error) in
            if let response = response {
                print("\(response.photos.currentPage)")
            }
        }
    }
}

