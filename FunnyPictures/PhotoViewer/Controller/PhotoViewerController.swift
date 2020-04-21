//
//  PhotoViewerController.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 02/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

class PhotoViewerController: UIViewController {
    
    private let networkManager = NetworkManager()
    private let collectionManager = MyCollectionManager()
    
    var query = ""
    private var photoID = ""
    
    @IBOutlet weak var viewerSubview: ViewerSubview!
    
    @IBAction func tapNextPhotoButton(_ sender: UIButton) {
        fetchRandomPhoto(for: query)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = query
        addDoubleTapGestue()
        showHintAlert(.photoViewer)
        fetchRandomPhoto(for: query)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = fetchBackgroundColor()
    }
    
    func fetchRandomPhoto(for query: String) {
        viewerSubview.startActivityIndicator()
        networkManager.fetchRawPhotoData(request: .randomPhoto(query)) { [weak self] (result: Result<RawPhotoData, NetworkError>) in
            switch result {
            case .success(let rawPhotoData):
                let photo = Photo(rawPhotoData)
                self?.photoID = photo.id
                self?.viewerSubview.updateView(with: photo)
            case .failure(let networkError):
                let errorDescription = networkError.errors[0]
                self?.showErrorAlert(with: errorDescription)
            }
        }
    }
    
     // MARK: - Double Tap Gesture
    
    func addDoubleTapGestue() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(addToCollection))
        doubleTap.numberOfTapsRequired = 2
        viewerSubview.photoImageView.addGestureRecognizer(doubleTap)
        viewerSubview.photoImageView.isUserInteractionEnabled = true
    }
    
    @objc func addToCollection() {
        collectionManager.addToCollection(photoID)
        viewerSubview.showStarImage()
    }
    
}
