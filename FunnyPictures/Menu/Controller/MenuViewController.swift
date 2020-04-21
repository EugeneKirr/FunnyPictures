//
//  MenuViewController.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 06/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    private let tagListManager = TagListManager()
    
    private var tagList: TagList {
        return tagListManager.fetchTagList()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableViewCell()
        configureNavBar(title: "Menu") {
            let navAddButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.tapAddButton))
            self.navigationItem.rightBarButtonItem = navAddButton
        }
        showHintAlert(.menu)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.backgroundColor = fetchBackgroundColor()
    }
    
    func registerTableViewCell() {
        let nib = UINib(nibName: "MenuCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "menuCell")
    }
    
    // MARK: - NavBar Action
    
    @objc func tapAddButton() {
        let ac = UIAlertController(title: "Enter new tag", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (_) in
            let newTag = ac.textFields?.first?.text
            self.tagListManager.addToTagList(newTag)
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        ac.addAction(ok)
        ac.addAction(cancel)
        ac.addTextField { (textField) in
            textField.autocapitalizationType = .sentences
        }
        present(ac, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagList.tags.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as? MenuCell else { return UITableViewCell() }
        cell.tagLabel.text = tagList.tags[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let photoViewerSB = UIStoryboard(name: "PhotoViewer", bundle: nil)
        guard let photoVC = photoViewerSB.instantiateViewController(withIdentifier: "photoViewerController") as? PhotoViewerController else { return }
        photoVC.query = tagList.tags[indexPath.row]
        
        self.navigationController?.pushViewController(photoVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Swipe actions
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            self.tagListManager.removeFromTagList(tagIndex: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }

}


