//
//  ViewerSubview.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 12/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

class ViewerSubview: UIView {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var downloadsLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorLocationLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        let nib = UINib(nibName: "ViewerSubview", bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        self.addSubview(view)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.subviews.first?.frame = self.frame
    }
    
    func startActivityIndicator() {
        activityIndicator.startAnimating()
        photoImageView.alpha = 0.5
    }
        
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
        photoImageView.alpha = 1.0
    }
    
    func updateView(with photo: Photo) {
        self.photoImageView.image = photo.image
        self.viewsLabel.text = photo.viewsCount
        self.likesLabel.text = photo.likesCount
        self.downloadsLabel.text = photo.downloadsCount
        self.descriptionLabel.text = photo.description
        self.authorNameLabel.text = photo.authorName
        self.authorLocationLabel.text = photo.authorLocation ?? "no location information"
        stopActivityIndicator()
    }
    
    func showStarImage() {
        UIView.animate(withDuration: 0.2, animations: {
            self.starImageView.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                self.starImageView.alpha = 0.0
            }
        }
    }
    
}


