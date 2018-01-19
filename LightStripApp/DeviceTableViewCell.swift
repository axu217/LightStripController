//
//  DeviceTableViewCell.swift
//  LightStripApp
//
//  Created by Zhe Xu on 2018/01/07.
//  Copyright © 2018 ZheChengXu. All rights reserved.
//

import UIKit

class DeviceTableViewCell: UITableViewCell {

    var device: Device!
    var delegate: DeviceTableViewCellDelegate!
    @IBOutlet weak var deviceNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func manageDevice(_ sender: Any) {
        self.delegate.deviceCellManageClicked(device: self.device)
    }
    
}

protocol DeviceTableViewCellDelegate {
    
    func deviceCellManageClicked(device: Device)
}
