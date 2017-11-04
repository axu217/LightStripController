//
//  DevicesViewController.swift
//  LightStripController
//
//  Created by AXE07 on 10/14/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit

class DevicesViewController: UITableViewController {

    var deviceStore: DeviceStore!
    
    @objc func addItem(sender: UIBarButtonItem!) {
        performSegue(withIdentifier: "addDevice", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addDevice" {
            let dest = segue.destination as! AddDeviceViewController
            dest.deviceStore = deviceStore
        } else if segue.identifier == "controlDevice" {
            if let row = tableView.indexPathForSelectedRow?.row {
                let device = deviceStore.allDevices[row]
                let detailViewController = segue.destination as! ColorsCollectionViewController
                
                detailViewController.device = device
            }
        } else {
            
        }
    }
    
    // MARK: View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0xE8ECEE)
        
        tableView.rowHeight = 65
        tableView.estimatedRowHeight = 65
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.deviceStore = appDelegate.deviceStore
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tab = self.parent as! HomeTabViewController
        tab.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        tab.navigationItem.title = "Devices"
        tab.navigationItem.leftBarButtonItem = editButtonItem
        
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let tab = self.parent as! HomeTabViewController
        tab.navigationItem.rightBarButtonItem = nil
        tab.navigationItem.leftBarButtonItem = nil
    }
    
   
    
    
    
    
}

extension DevicesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return deviceStore.allDevices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceCell", for: indexPath) as! DeviceCell
        let device = deviceStore.allDevices[indexPath.row]
        cell.deviceNameLabel?.text = device.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let device = deviceStore.allDevices[indexPath.row]
            
            let title = "Delete \(device.name)"
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
