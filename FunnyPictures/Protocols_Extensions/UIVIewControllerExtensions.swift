//
//  UIViewControllerExtensions.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 10/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func configureNavBar(title: String, completionHandler: (() -> Void)? ) {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.systemYellow
        self.navigationItem.title = title
        completionHandler?()
    }
    
}

extension UIViewController {
    
    func showHintAlert(_ hint: Hints) {
        guard !fetchHintFlag(udKey: hint.udKey) else { return }
        let ac = UIAlertController(title: hint.hintText, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(ok)
        present(ac, animated: true)
        addHintFlag(udKey: hint.udKey)
    }
    
    fileprivate func fetchHintFlag(udKey: String) -> Bool {
        let defaults = UserDefaults.standard
        guard let isHintShown = defaults.object(forKey: udKey) as? Bool else { return false }
        return isHintShown
    }
    
    fileprivate func addHintFlag(udKey: String) {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: udKey)
    }
    
}

extension UIViewController {
    
    func fetchBackgroundColor() -> UIColor {
        let rgb = fetchRGBValues()
        return UIColor(red: CGFloat(rgb[0]), green: CGFloat(rgb[1]), blue: CGFloat(rgb[2]), alpha: 1.0)
    }
    
    func fetchRGBValues() -> [Float] {
        let defaults = UserDefaults.standard
        guard let rgb = defaults.object(forKey: UDKeys.customizer.rawValue) as? [Float] else { return [1.0, 1.0, 1.0] }
        return rgb
    }
    
}

extension UIViewController {

    func showErrorAlert(with description: String) {
        let ac = UIAlertController(title: description, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        ac.addAction(ok)
        present(ac, animated: true, completion: nil)
    }

}
