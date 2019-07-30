//
//  ImageSearchViewController.swift
//  FlickrImageSearch
//
//  Created by Vandan Patel on 7/29/19.
//  Copyright © 2019 Vandan Patel. All rights reserved.
//

import UIKit

var photoCellReuseIdentifier = "photoCell"

// MARK: - ImageSearchViewable Protocol
protocol ImageSearchViewable {
    func show(_ photos: [PhotoUIModel])
}

class ImageSearchViewController: UIViewController {
    
    // MARK: - Instance Variables & Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    var photos = [PhotoUIModel]()
    var presenter: ImageSearchPresentable?
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


// MARK: - CollectionView Configuration
extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellReuseIdentifier,
                                                            for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        cell.presenter = self.presenter
        cell.populateCell(withPhoto: self.photos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2, height: view.frame.width / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - ImageSearchViewable Conformation
extension ImageSearchViewController: ImageSearchViewable {
    func show(_ photos: [PhotoUIModel]) {
        self.photos = photos
        DispatchQueue.main.async { self.collectionView.reloadData() }
    }
}
