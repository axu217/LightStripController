//
//  AddFavoriteViewController.swift
//  LightStripApp
//
//  Created by AXE07 on 11/1/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit

class AddFavoriteViewController: UITableViewController {
    
    
    var deviceStore: DeviceStore! {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.deviceStore
        }
    }
    
    var device: Device!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deviceStore.count()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.selectFavoriteCell, for: indexPath) as! AddFavoriteCell
        cell.titleLabel.text = deviceStore.allDevices[index].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        deviceStore.favoriteDevice = deviceStore.getDeviceByIndex(index: index)
        self.navigationController?.popViewController(animated: true)
    }
}

class AddFavoriteCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    

}





