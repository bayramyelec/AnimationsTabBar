//
//  MainVC.swift
//  AnimationsTabBar
//
//  Created by Bayram Yeleç on 14.02.2025.
//

import UIKit

class MainVC: UIViewController {
    
    private let tabbarController = CustomTabbar()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup(){
        view.backgroundColor = .white
        view.addSubview(tabbarController)
        tabbarController.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tabbarController.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20),
            tabbarController.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20),
            tabbarController.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -30),
        ])
    }

}
