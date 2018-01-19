//
//  HomeViewController.swift
//  LightStripApp
//
//  Created by Zhe Xu on 2018/01/07.
//  Copyright © 2018 ZheChengXu. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DeviceTableViewCellDelegate {
    
    var deviceStore: DeviceStore!
    
    @IBOutlet var hubIDOutlet: UILabel!
    @IBOutlet var hubStatusLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var tempDevice: Device?

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = AppMeta.AppDelegate
        self.deviceStore = appDelegate.deviceStore
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 84
        tableView.rowHeight = 84

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.deviceToAddDevice {
            let dest = segue.destination as! AddDeviceViewController
            dest.deviceStore = deviceStore
        } else if segue.identifier == Constants.deviceToControlDevice {
            let dest = segue.destination as! ControlDeviceViewController
            dest.device = tempDevice!
        } else {
            print("error lmao")
        }
    }
    
    func deviceCellManageClicked(device: Device) {
        tempDevice = device
        self.performSegue(withIdentifier: Constants.deviceToControlDevice, sender: self)
    }
}

extension HomeViewController {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.deviceTableCell, for: indexPath) as! DeviceTableViewCell
        
        let device = deviceStore.getDeviceByIndex(index: indexPath.row)
        cell.device = device
        cell.delegate = self
        cell.deviceNameLabel.text = device.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = deviceStore.count()
        
        if(count > 0) {
            return count
        } else {
            //showEmptyMessage(message: "You have no devices")
            
            
            let rect = CGRect(x: 0, y: 0, width: tableView.bounds.size.height, height: tableView.bounds.size.width)
            let messageLabel = UILabel(frame: rect)
            messageLabel.bounds = messageLabel.frame.insetBy(dx: 30.0, dy: 0)
            messageLabel.text = "You have no devices"
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.sizeToFit()
            
            tableView.backgroundView = messageLabel;
            tableView.separatorStyle = .none
            
            
            return 0
        }
    }
}
