//
//  DevicesViewController.swift
//  LightStripController
//
//  Created by AXE07 on 10/14/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit

class DevicesViewController: UITableViewController {

    static let navTitle = "Devices"
    var deviceStore: DeviceStore!
    var colorStore: ColorStore!
    
    @objc func addItem(sender: UIBarButtonItem!) {
        performSegue(withIdentifier: Constants.deviceToAddDevice, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.deviceToAddDevice {
            let dest = segue.destination as! AddDeviceViewController
            dest.deviceStore = deviceStore
        } else if segue.identifier == Constants.deviceToControlDevice {
            if let row = tableView.indexPathForSelectedRow?.row {
                let device = deviceStore.allDevices[row]
                let detailViewController = segue.destination as! DeviceControlController
                detailViewController.colorStore = colorStore
                detailViewController.device = device
            }
        } else {
            
        }
    }
    
    // MARK: View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 65
        tableView.estimatedRowHeight = 65
        
        let appDelegate = AppMeta.AppDelegate
        self.deviceStore = appDelegate.deviceStore
        self.colorStore = appDelegate.colorStore
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        navigationItem.title = DevicesViewController.navTitle
        navigationItem.leftBarButtonItem = editButtonItem
        
        tableView.reloadData()
    }
    
    
    

    
    
    
    
    
}

extension DevicesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return deviceStore.count()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.deviceTableCell, for: indexPath) as! DeviceCell
        let device = deviceStore.getDeviceByIndex(index: indexPath.row)
        cell.deviceNameLabel?.text = device.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let device = deviceStore.getDeviceByIndex(index: indexPath.row)
            
            let title = "Delete \(device.name!)"
            let message = "Are you sure you want to delete this device?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteLambda = { (action: UIAlertAction) -> Void in
                self.deviceStore.deleteDevice(device)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: deleteLambda)
            ac.addAction(deleteAction)
            
            self.present(ac, animated: true, completion: nil)
            
            
        }
    }
    
}
