//
//  CollectionViewerController.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 09/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

class CollectionViewerController: UIViewController {
    
    private let networkManager = NetworkManager()
    
    var index = 0
    var myCollection = MyCollection(identifiers: [])
    
    @IBOutlet weak var viewerSubview: ViewerSubview!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    
    @IBAction func tapButton(_ sender: UIButton) {
        sender == nextButton ? (index += 1) : (index -= 1)
        checkIndex()
        fetchPhoto(by: myCollection.identifiers[index])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Collection Photos"
        checkIndex()
        fetchPhoto(by: myCollection.identifiers[index])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = fetchBackgroundColor()
    }
    
    func checkIndex() {
        guard myCollection.identifiers.count > 1 else {
            switchButtonsTo(off: [nextButton, previousButton])
            return
        }
        switch index {
        case 0:
            switchButtonsTo(on: [nextButton], off: [previousButton])
        case (myCollection.identifiers.count - 1):
            switchButtonsTo(on: [previousButton], off: [nextButton])
        default:
            switchButtonsTo(on: [nextButton, previousButton])
        }
    }
    
    func fetchPhoto(by id: String) {
        viewerSubview.startActivityIndicator()
        networkManager.fetchRawPhotoData(request: .byID(id)) { [weak self] (result: Result<RawPhotoData, NetworkError>) in
            switch result {
            case .success(let rawPhotoData):
                let photo = Photo(rawPhotoData)
                self?.viewerSubview.updateView(with: photo)
            case .failure(let networkError):
                let errorDescription = networkError.errors[0]
                self?.showErrorAlert(with: errorDescription)
            }
        }
    }
    
    func switchButtonsTo(on: [UIButton]? = nil, off: [UIButton]? = nil) {
        if let buttons = on {
            for button in buttons {
                button.isEnabled = true
                button.backgroundColor = .systemYellow
            }
        }
        if let buttons = off {
            for button in buttons {
                button.isEnabled = false
                button.backgroundColor = .lightGray
            }
        }
    }

}

