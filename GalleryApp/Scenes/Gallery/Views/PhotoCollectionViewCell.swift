//
//  PhotoCell.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/15/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCellIdentifier"
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageViewPhoto: UIImageView!
    
    var viewModel: PhotoViewModelType! {
        didSet {
            updateUI()
        }
    }
}

extension PhotoCollectionViewCell {
    
    private func updateUI() {
        labelTitle.text = viewModel.title
        imageViewPhoto.sd_setImage(with: URL(string: viewModel.image), placeholderImage: nil, options: SDWebImageOptions.progressiveDownload, completed: nil)
        
    }
}
