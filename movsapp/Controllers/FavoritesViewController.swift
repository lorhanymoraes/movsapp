//
//  FavoritesViewController.swift
//  movsapp
//
//  Created by Lorhany Moraes on 06/12/22.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet var topView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner]
    }

    

}
