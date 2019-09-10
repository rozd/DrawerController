//
//  ViewController.swift
//  Demo
//
//  Created by Max Rozdobudko on 9/9/19.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit
import DrawerController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton()
        button.setTitle("Test Button", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }


}

