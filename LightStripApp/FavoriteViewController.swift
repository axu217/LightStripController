//
//  FavoriteViewController.swift
//  LightStripController
//
//  Created by AXE07 on 10/14/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit
import Firebase

class FavoriteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    static let title = "Favorite"
    
    var isNoFavoriteState: Bool?
    
    @IBOutlet var favoriteTitleLabel: UILabel!
    @IBOutlet var solidColorsCollectionView: UICollectionView!
    @IBOutlet var fullView: UIView!
    @IBOutlet var noFavoriteView: UIView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBAction func userTurnedOn(_ sender: UIButton) {
        NetworkFacade.turnOnOffDevice(device: favoriteDevice, turnOn: true)
    }
    
    @IBAction func userTurnedOff(_ sender: UIButton) {
        NetworkFacade.turnOnOffDevice(device: favoriteDevice, turnOn: false)
    }
    
    @IBAction func userChangeMode(_ sender: UISegmentedControl) {
        
        let index = sender.selectedSegmentIndex
        if(index == 0) {
        } else if (index == 1) {
            NetworkFacade.setGradientMode(device: favoriteDevice)
        } else {
            NetworkFacade.setTwinkleMode(device: favoriteDevice)
        }
    }
    
    var deviceStore: DeviceStore! = AppMeta.AppDelegate.deviceStore
    
    var colorStore: ColorStore! = AppMeta.AppDelegate.colorStore
    
    var favoriteDevice: Device! = AppMeta.AppDelegate.deviceStore.favoriteDevice

    override func viewDidLoad() {
        super.viewDidLoad()
        solidColorsCollectionView.delegate = self
        solidColorsCollectionView.dataSource = self
        
        segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
   
        segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: UIControlState.selected, rightSegmentState: .normal, barMetrics: .default)
        
        segmentedControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .selected, barMetrics: .default)
        
        if(favoriteDevice == nil) {
            self.noFavoriteView.isHidden = false
            self.fullView.isHidden = true
            isNoFavoriteState = true
        } else {
            self.noFavoriteView.isHidden = true
            self.fullView.isHidden = false
            isNoFavoriteState = false
            favoriteTitleLabel.text = favoriteDevice.name
        }
    }
    
    @objc func selectFavorite() {
        self.performSegue(withIdentifier: Constants.favoriteToSelectFavorite, sender: self)
    }
    

    //YO fam this is supposed to listen to some sort of shit. IDK what now but you can figure it out later. Like listen for updates? Maybe just scratch is all together.
    @objc func handleReceivedStatus(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let dict = userInfo[Constants.message] as! [String: String]
        
        print("handled")
        print(dict)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(selectFavorite))
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleReceivedStatus), name: NSNotification.Name(rawValue: Constants.message), object: nil)
        
        if(favoriteDevice == nil && isNoFavoriteState == false) {
            self.noFavoriteView.isHidden = false
            self.fullView.isHidden = true
            isNoFavoriteState = true
        }
        
        if (favoriteDevice != nil && isNoFavoriteState == true){
            self.noFavoriteView.isHidden = true
            self.fullView.isHidden = false
            isNoFavoriteState = false
            
            solidColorsCollectionView.reloadData()
            favoriteTitleLabel.text = favoriteDevice.name
            
        }
   
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

}

extension FavoriteViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorStore.count()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = solidColorsCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.favoriteCollectionCell, for: indexPath) as! ColorCell
        cell.backgroundColor = colorStore.getColorByIndex(index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let color = colorStore.getColorByIndex(index: indexPath.row)
        
        NetworkFacade.setColor(device: favoriteDevice, color: color)

        let alertController = UIAlertController.createAlert(title: "Command Sent!", message: "Press dismiss to dismiss this message")
        
        alertController.customAddAction(title: "Dismiss", lambda: {() -> () in
            alertController.dismiss(animated: true, completion: nil)
        })
        
        self.present(alertController, animated: true, completion: nil)

    }
}




