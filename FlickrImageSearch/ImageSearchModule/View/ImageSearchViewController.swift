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
    func scrollToTheTop()
}

class ImageSearchViewController: UIViewController {
    
    // MARK: - Instance Variables & Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    var photos = [PhotoUIModel]()
    var presenter: ImageSearchPresentable?
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureActivityIndicatorView()
        configureNavigationBar()
    }
    
    //MARK: - Configure UI Components
    func configureActivityIndicatorView() {
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        let searchResultsController = UISearchController(searchResultsController: nil)
        searchResultsController.searchResultsUpdater = self
        searchResultsController.obscuresBackgroundDuringPresentation = false
        searchResultsController.searchBar.placeholder = "Search Food"
        navigationItem.searchController = searchResultsController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}


// MARK: - CollectionView Configuration
extension ImageSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    fileprivate func buildCellVIPER(_ cell: PhotoCell, _ photo: PhotoUIModel) {
        let cellInteractor = PhotoCellInteractor(networkManager: NetworkManager())
        let cellPresenter = PhotoCellPresenter(view: cell, interactor: cellInteractor, photo: photo)
        cellInteractor.cellPresenter = cellPresenter
        cell.presenter = cellPresenter
        cellPresenter.loadImage()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellReuseIdentifier,
                                                            for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        buildCellVIPER(cell, self.photos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 3, height: view.frame.width / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as! PhotoCell
        guard let selectedImage = selectedCell.photoImageView.image else { return }
        presenter?.didSelectImage(selectedImage)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height && contentHeight > 0 {
            guard let presenter = presenter else { return }
            if (!presenter.fetchingMore)  {
                activityIndicator.startAnimating()
                presenter.getNextPageResults()
            }
        }
    }
}

// MARK: - ImageSearchViewable Conformation
extension ImageSearchViewController: ImageSearchViewable {
    func scrollToTheTop() {
        collectionView.setContentOffset(.zero, animated: true)
    }
    
    func show(_ photos: [PhotoUIModel]) {
        self.photos = photos
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UISearchResultsUpdating
extension ImageSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        activityIndicator.startAnimating()
        presenter?.getNewSearchResults(forSearchTest: text)
    }
}
