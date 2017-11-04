//
//  FavoriteViewController.swift
//  LightStripController
//
//  Created by AXE07 on 10/14/17.
//  Copyright © 2017 ZheChengXu. All rights reserved.
//

import UIKit
import Firebase

class FavoriteViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    var favoriteStore: FavoriteStore!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(rgb: 0xE8ECEE)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.favoriteStore = appDelegate.favoriteStore
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 120)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: "favoritesCell")
        collectionView.backgroundColor = UIColor(rgb: 0xE8ECEE)
        self.view.addSubview(collectionView)
        
        //if empty, have label saying no favorites
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let tab = self.parent as! HomeTabViewController
        tab.navigationItem.title = "Favorites"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func logout(sender: UIButton) {
        
        try! Auth.auth().signOut()
        
        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
        
        self.performSegue(withIdentifier: "logout", sender: self)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteStore.favoriteDevices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoritesCell", for: indexPath) as! FavoritesCell
        cell.titleTextField.text = favoriteStore.favoriteDevices[indexPath.row].name
        return cell
    }
}

class FavoritesCell: UICollectionViewCell {
    
    var titleTextField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleTextField = UITextField()
        let margins = contentView.layoutMarginsGuide
        titleTextField.textAlignment = .center
        titleTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        
        // Pin the trailing edge of myView to the margin's trailing edge
        titleTextField.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        
        
        
        self.contentView.addSubview(titleTextField)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
}
