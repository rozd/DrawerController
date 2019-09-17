//
//  File.swift
//  
//
//  Created by Max Rozdobudko on 9/17/19.
//

#if canImport(UIKit)

import UIKit

public extension UIViewController {

    open var drawerController: DrawerController? {
        return parent as? DrawerController
    }

}

#endif
