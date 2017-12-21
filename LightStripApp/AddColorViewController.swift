//
//  AddColorViewController.swift
//  LightStripApp
//
//  Created by AXE07 on 11/1/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit
import ChromaColorPicker

class AddColorViewController: UIViewController, ChromaColorPickerDelegate {
    
    @IBOutlet var pickerView: UIView!
    
    var chromaColorPicker: ChromaColorPicker!
    var colorStore: ColorStore!
    
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        colorStore.addColor(color: chromaColorPicker.currentColor)
        navigationController?.popViewController(animated: true)
    }
    // MARK: View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0xE8ECEE)
        
        let neatColorPicker = ChromaColorPicker(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        neatColorPicker.delegate = self //ChromaColorPickerDelegate
        neatColorPicker.padding = 5
        neatColorPicker.stroke = 3
        neatColorPicker.hexLabel.textColor = UIColor.black
        self.chromaColorPicker = neatColorPicker
        
        let margins = pickerView.layoutMarginsGuide
        pickerView.addSubview(neatColorPicker)
        neatColorPicker.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        neatColorPicker.centerXAnchor.constraint(equalTo: margins.centerXAnchor).isActive = true
       
        
        pickerView.backgroundColor = UIColor(rgb: 0xE8ECEE)
        
        neatColorPicker.layoutIfNeeded()
    }
    
    
    
    
}
