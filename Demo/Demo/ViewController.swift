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
        button.setTitle("Button from Code", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .body)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 12.0),
            button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

    @IBAction func openBottomDrawerButtonTapped(_ sender: Any) {
        self.drawerController?.openBottomViewController(animated: true)
    }

}

