//
//  ColorsCollectionViewController.swift
//  LightStripApp
//
//  Created by AXE07 on 10/25/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit
import CocoaMQTT

class ColorsCollectionViewController: UICollectionViewController, UIGestureRecognizerDelegate {
    
    
    var alertController: UIAlertController?
    
    var colorStore: ColorStore! {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.colorStore
        }
    }
    var device: Device!
    
    @objc func addColor() {
        performSegue(withIdentifier: Constants.colorToAddColor, sender: self)
    }
    
    @objc func receivedMessage(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let dict = userInfo[Constants.message] as! [String: String]
        
        if (dict.keys.contains(Constants.status)) && dict[Constants.status] == "Pass"  {
            
            self.alertController?.title = "Success"
            self.alertController?.message = "Response successful"
            self.alertController?.view.setNeedsLayout()
            self.alertController?.view.setNeedsDisplay()
            
        } else {
            
            self.alertController?.title = "Failure"
            self.alertController?.message = "Please check your internet conection and try again"
            
        }
    }
    
    // MARK: View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addColor))
        
        collectionView?.reloadData()
        
        let name = NSNotification.Name(rawValue: Constants.message)
        NotificationCenter.default.addObserver(self, selector: #selector(receivedMessage(notification:)), name: name, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0xE8ECEE)
        collectionView!.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.collectionView?.addGestureRecognizer(lpgr)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        let pointLocation = gestureRecognizer.location(in: self.collectionView)
        if let index = self.collectionView?.indexPathForItem(at: pointLocation)?.row {
            let alertController = UIAlertController(title: "Delete Color", message: "Are you sure you want to delete this color?", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Yes", style: .destructive, handler: { (UIAlertAction) in
                self.colorStore.removeColorByIndex(index: index);
                alertController.dismiss(animated: true, completion: nil)
                self.collectionView?.reloadData()
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
                alertController.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        
        
        
        
    }
    
    
    
}

extension ColorsCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorStore.count()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.colorCollectionCell, for: indexPath) as! ColorCell
        cell.backgroundColor = colorStore.getColorByIndex(index: indexPath.row)
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = colorStore.getColorByIndex(index: indexPath.row)
        
        NetworkFacade.setColor(device: device, color: color)

        self.alertController = UIAlertController(title: "Sending Command", message: "Please wait until the server responds", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .default, handler: { _ in
            self.alertController!.dismiss(animated: true, completion: nil)
        })
        alertController!.addAction(action)
        self.present(alertController!, animated: true, completion: nil)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
