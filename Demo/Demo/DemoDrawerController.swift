//
//  DemoDrawerController.swift
//  Demo
//
//  Created by Max Rozdobudko on 9/11/19.
//  Copyright © 2019 Max Rozdobudko. All rights reserved.
//

import UIKit
import DrawerController

class DemoDrawerController: DrawerController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }
}

extension DemoDrawerController: DrawerControllerDelegate {

    func drawerController(_ controller: DrawerController, closedFrameForBottomDrawer drawer: UIViewController?) -> CGRect {
        return CGRect(x: 0.0, y: view.frame.height - 44.0, width: view.bounds.width, height: view.bounds.height + 44.0)
    }

    func drawerController(_ controller: DrawerController, openedFrameForBottomDrawer drawer: UIViewController?) -> CGRect {
        return CGRect(x: 0.0, y: -44.0, width: view.bounds.width, height: view.bounds.height + 44.0)
    }
    
}
