//
//  MyCollectionViewController.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 06/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

class MyCollectionViewController: UICollectionViewController {
    
    private let networkManager = NetworkManager()
    private let collectionManager = MyCollectionManager()
    
    private var willDeleteCells = false {
        willSet {
            self.navigationItem.rightBarButtonItem?.image = newValue ? UIImage(systemName: "trash.fill") : UIImage(systemName: "trash")
        }
    }
    
    private var myCollection: MyCollection {
        return collectionManager.fetchCollection()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCollectionViewCell()
        showHintAlert(.myCollection)
        configureNavBar(title: "My Collection") {
            let navTrashButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(self.tapTrashButton))
            self.navigationItem.rightBarButtonItem = navTrashButton
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        willDeleteCells = false
        self.collectionView.backgroundColor = fetchBackgroundColor()
        self.collectionView.reloadData()
    }
    
    func registerCollectionViewCell() {
        let nib = UINib(nibName: "MyCollectionCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "myCollectionCell")
    }
    
    // MARK: - NavBar Action
    
    @objc func tapTrashButton() {
        self.willDeleteCells = !self.willDeleteCells
    }

    // MARK: - UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myCollection.identifiers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCollectionCell", for: indexPath) as? MyCollectionCell else { return UICollectionViewCell() }
        cell.thumbImageView.image = UIImage(systemName: "photo")
        cell.backgroundColor = fetchBackgroundColor()
        cell.thumbImageView.contentMode = .scaleAspectFit
        
        let id = myCollection.identifiers[indexPath.row]
        networkManager.fetchRawPhotoData(request: .byID(id)) { [weak self] (result: Result<RawPhotoData, NetworkError>) in
            switch result {
            case .success(let rawPhotoData):
                let thumb = Thumb(rawPhotoData)
                cell.thumbImageView.image = thumb.thumbnail
                cell.thumbImageView.contentMode = .scaleAspectFill
            case .failure(let networkError):
                let errorDescription = networkError.errors[0]
                self?.showErrorAlert(with: errorDescription)
            }
        }
        return cell
    }

    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !willDeleteCells else {
            collectionManager.removeFromCollection(cellIndex: indexPath.row)
            self.collectionView.deleteItems(at: [indexPath])
            return
        }
        let collectionViewerSB = UIStoryboard(name: "CollectionViewer", bundle: nil)
        guard let collectionVC = collectionViewerSB.instantiateViewController(identifier: "collectionViewerController") as? CollectionViewerController else { return }
        collectionVC.myCollection = myCollection
        collectionVC.index = indexPath.row
        self.navigationController?.pushViewController(collectionVC, animated: true)
    }

}

// MARK: - Adaptive Cell Size

extension MyCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCellsInRow = 3
        let cellSize = (collectionView.bounds.width / CGFloat(numberOfCellsInRow))
        return CGSize(width: cellSize, height: cellSize)
    }
    
}
