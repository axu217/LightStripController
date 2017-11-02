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
    
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        colorStore.addColor(color: chromaColorPicker.currentColor)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    var chromaColorPicker: ChromaColorPicker!
    
    var colorStore: ColorStore! {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.colorStore
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0xE8ECEE)
        
        let neatColorPicker = ChromaColorPicker(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        neatColorPicker.delegate = self //ChromaColorPickerDelegate
        neatColorPicker.padding = 5
        neatColorPicker.stroke = 3
        neatColorPicker.hexLabel.textColor = UIColor.black
        self.chromaColorPicker = neatColorPicker
        
       
        view.addSubview(neatColorPicker)
        neatColorPicker.center = self.view.center
        neatColorPicker.layoutIfNeeded()
    }
    
    
    
    
}
