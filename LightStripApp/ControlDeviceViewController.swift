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
    @IBOutlet var deviceTitle: UILabel!
    @IBOutlet var deviceOnlineStatusLabel: UILabel!
    
    @IBOutlet var deviceModeButton: UIButton!
    @IBOutlet var deviceColorButton: UIButton!
    @IBOutlet var deviceSpeedButton: UIButton!
    
    @IBOutlet var deviceWeekdayScheduleButton: UIButton!
    @IBOutlet var deviceStartTimeButton: UIButton!
    @IBOutlet var deviceEndTimeButton: UIButton!
    
    @IBAction func back(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated);
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
                
            case .dynamic:
                self.deviceModeButton.setTitle("Dynamic", for: .normal)
                NetworkFacade.getDeviceSpeed {speed in
                    self.deviceSpeedButton.setTitle("\(speed)", for: .normal)
                }
                
            case .gradient:
                self.deviceModeButton.setTitle("Gradient", for: .normal)
                NetworkFacade.getDeviceSpeed{speed in
                    self.deviceSpeedButton.setTitle("\(speed)", for: .normal)
                }
                
            }
        }
        
        NetworkFacade.getStatusActual(device: device)
        
        
        
        NetworkFacade.getDeviceWeekdaySchedule { weekdayArray in
            var buildString = ""
            let weekdayNames = ["S", "M", "T", "W", "Th", "F", "S"]
            for (index, hasDay) in weekdayArray.enumerated() {
                if(hasDay) {
                    if(index != 6) {
                        buildString = buildString + weekdayNames[index] + ", "
                    } else {
                        buildString = buildString + weekdayNames[index]
                    }
                    
                }
            }
            
            self.deviceWeekdayScheduleButton.setTitle(buildString, for: .normal)
            
        }

        NetworkFacade.getDeviceStartTime { startTime in
            self.deviceStartTimeButton.setTitle(startTime, for: .normal)
        }
        
        
        NetworkFacade.getDeviceEndTime { endTime in
            self.deviceEndTimeButton.setTitle(endTime, for: .normal)
        }
        NetworkFacade.getScheduleActual(device: device)
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
