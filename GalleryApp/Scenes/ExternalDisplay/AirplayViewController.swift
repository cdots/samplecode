//
//  AirplayViewController.swift
//  GalleryApp
//
//  Created by Kishore Vaddadi on 9/16/18.
//  Copyright © 2018 Kishore Vaddadi. All rights reserved.
//

import UIKit
import SDWebImage

class AirplayViewController: UIViewController {
    @IBOutlet weak var imageViewExternalDisplay: UIImageView!
    
    var image:UIImage? = nil
    
    override func viewDidLoad() {
         super.viewDidLoad()
        imageViewExternalDisplay.image = image
    }
}

