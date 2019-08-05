//
//  FullImageViewController.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 8/4/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import UIKit

class FullImageViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    var imageData: Data!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.image = UIImage(data: imageData)
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
