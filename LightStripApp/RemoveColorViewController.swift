//
//  RemoveColorViewController.swift
//  LightStripApp
//
//  Created by Zhe Xu on 2017/12/21.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit

class RemoveColorViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    var colorStore: ColorStore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}


extension RemoveColorViewController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorStore.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.colorCollectionCell, for: indexPath) as! ColorCell
        cell.backgroundColor = colorStore.getColorByIndex(index: indexPath.row)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let index = indexPath.row
        
        let alertController = UIAlertController(title: "Delete Color", message: "Are you sure you want to delete this color?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Yes", style: .destructive, handler: { (UIAlertAction) in
            self.colorStore.removeColorByIndex(index: index);
            alertController.dismiss(animated: true, completion: nil)
            self.collectionView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            alertController.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView!) -> Int {
        return 1
    }
    
}
