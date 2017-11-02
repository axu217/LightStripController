//
//  AddFavoriteViewController.swift
//  LightStripApp
//
//  Created by AXE07 on 11/1/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit

class AddFavoriteViewController: UITableViewController {
    
    
    var favoriteStore: FavoriteStore! {
        get {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.favoriteStore
        }
    }
    var device: Device!
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteStore.favoriteDevices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddFavoriteCell", for: indexPath) as! AddFavoriteCell
        cell.titleTextField.text = favoriteStore.favoriteDevices[index].name
        return cell
    }
}

class AddFavoriteCell: UITableViewCell {
    
    @IBOutlet var titleTextField: UITextField!
    

}





