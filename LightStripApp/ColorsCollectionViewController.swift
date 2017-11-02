//
//  ColorsCollectionViewController.swift
//  LightStripApp
//
//  Created by AXE07 on 10/25/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit

class ColorsCollectionViewController: UICollectionViewController {
    
    var colorStore: ColorStore! {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.colorStore
        }
    }
    var device: Device!
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addColor))
        
        collectionView?.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorStore.allColors.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as! ColorCell
        cell.backgroundColor = colorStore.allColors[indexPath.row]
        return cell
        
    }
    
    @objc func addColor() {
        performSegue(withIdentifier: "AddColor", sender: self)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(rgb: 0xE8ECEE)
    }
    
}
