//
//  ControlDeviceViewController.swift
//  LightStripApp
//
//  Created by Zhe Xu on 2018/01/07.
//  Copyright © 2018 ZheChengXu. All rights reserved.
//

import UIKit

class ControlDeviceViewController: UIViewController {

    var device: Device!
    
    @IBOutlet var mondayButton: UIButton!
    @IBOutlet var tuesdayButton: UIButton!
    @IBOutlet var wednesdayButton: UIButton!
    @IBOutlet var thursdayButton: UIButton!
    @IBOutlet var fridayButton: UIButton!
    @IBOutlet var saturdayButton: UIButton!
    @IBOutlet var sundayButton: UIButton!
    
    @IBOutlet var deviceTitle: UILabel!
    @IBOutlet var deviceOnlineStatusLabel: UILabel!
    
    @IBOutlet var deviceModeButton: UIButton!
    @IBOutlet var deviceColorButton: UIButton!
    @IBOutlet var deviceSpeedButton: UIButton!
    
    @IBOutlet var deviceWeekdayScheduleButton: UIButton!
    @IBOutlet var deviceStartTimeButton: UIButton!
    @IBOutlet var deviceEndTimeButton: UIButton!
    
    @IBAction func back(sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false);
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        deviceTitle.text = device.name
        
        NetworkFacade.getDeviceConnectionStatus() { isDeviceOnline in
            if(isDeviceOnline) {
                self.deviceOnlineStatusLabel.text = "Online"
            } else {
                self.deviceOnlineStatusLabel.text = "Offline"
            }
        }
        
        

        NetworkFacade.getDeviceMode { deviceMode in
            switch deviceMode {
            case .solid:
                self.deviceModeButton.setTitle("Solid", for: .normal)
                NetworkFacade.getDeviceColor {color in
                    self.deviceColorButton.backgroundColor = color
                }
                
            case .blink:
                self.deviceModeButton.setTitle("Dynamic", for: .normal)
                NetworkFacade.getDeviceSpeed {speed in
                    self.deviceSpeedButton.setTitle("\(speed)", for: .normal)
                }

            case .gradient:
                //dude I don't even know right now
                let temp = "10"
            }
        }
        
        NetworkFacade.getStatusActual(device: self.device)
        
        
        
        NetworkFacade.getDeviceWeekdaySchedule { weekdayArray in
            self.sundayButton.setTitle("\(weekdayArray[0])", for: .normal)
            self.mondayButton.setTitle("\(weekdayArray[1])", for: .normal)
            self.tuesdayButton.setTitle("\(weekdayArray[2])", for: .normal)
            self.wednesdayButton.setTitle("\(weekdayArray[3])", for: .normal)
            self.thursdayButton.setTitle("\(weekdayArray[4])", for: .normal)
            self.fridayButton.setTitle("\(weekdayArray[5])", for: .normal)
            self.saturdayButton.setTitle("\(weekdayArray[6])", for: .normal)
            
            
        }

        NetworkFacade.getDeviceStartTime { startTime in
            self.deviceStartTimeButton.setTitle(startTime, for: .normal)
        }
        
        NetworkFacade.getDeviceEndTime { endTime in
            self.deviceEndTimeButton.setTitle(endTime, for: .normal)
        }
        
        NetworkFacade.getScheduleActual(device: self.device)
        
        
        
        
    }


}
