//
//  CustomizerViewController.swift
//  FunnyPictures
//
//  Created by Eugene Kireichev on 09/04/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

class CustomizerViewController: UIViewController {

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBAction func changeSliderValue(_ sender: UISlider) {
        self.view.backgroundColor = UIColor(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: 1.0)
    }
    
    @IBAction func tapApplyButton(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        defaults.set([redSlider.value, greenSlider.value, blueSlider.value], forKey: UDKeys.customizer.rawValue)
    }
    
    @IBAction func tapUndoButton(_ sender: UIButton) {
        self.view.backgroundColor = fetchBackgroundColor()
        updateSliders()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar(title: "Settings", completionHandler: nil)
        self.view.backgroundColor = fetchBackgroundColor()
        updateSliders()
        showHintAlert(.customizer)
    }
        
    private func updateSliders() {
        let rgb = fetchRGBValues()
        redSlider.value = rgb[0]
        greenSlider.value = rgb[1]
        blueSlider.value = rgb[2]
    }
    
}
