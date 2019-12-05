//
//  GalleryViewController.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    @IBOutlet weak var searchBarQuery: UISearchBar!
    
    var viewModel: GalleryCollectionViewModelType?
    let errorView = ErrorView()
    
    var estimateWidth = 160.0
    var cellMarginSize = 16.0
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        self.title = "Loading..."
        
        setupCollectionViewLayout()
        
        viewModel?.loadPosts (searchQuery: "Berlin") {
            [weak self] in
            self?.title = "UnSplash"
            self?.photoCollectionView.reloadData()
        }
    }
}

// #MARK: setupUI
extension GalleryViewController {
    
    fileprivate func setupCollectionViewLayout() {
        photoCollectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        let layout  =  UICollectionViewFlowLayout()
        let width = (view.frame.width - 20) / 3
        layout.itemSize = CGSize(width: width, height: width)
        photoCollectionView.collectionViewLayout =  UICollectionViewFlowLayout()
    }
    
}

//MARK: Collectionview
extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfPosts() ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        
        let photoModel = viewModel?.postAt(index: indexPath.row)
        cell.viewModel = photoModel
        cell.backgroundColor = UIColor.black
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.didSelectAt(index: indexPath.row)
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

extension GalleryViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(searchBar.text!)
        
        searchBar.resignFirstResponder()
        self.title = "Loading.."
        
        viewModel?.loadPosts(searchQuery: searchBar.text!, {
            [weak self] in
            self?.photoCollectionView.reloadData()
            self?.title = "UnSplash"
        })
        
    }
}

extension GalleryViewController: PhotoCollectionViewModelDelegate {
    
    func showError(image: UIImage?, message: String) {
        errorView.message = message
        errorView.image = image
        errorView.alpha = 1
    }
    
    func hideError() {
        errorView.alpha = 0
    }
    
}


