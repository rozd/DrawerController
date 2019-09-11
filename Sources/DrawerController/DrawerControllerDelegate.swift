//
//  DrawerControllerDelegate.swift
//  
//
//  Created by Max Rozdobudko on 9/9/19.
//

#if canImport(UIKit)

import UIKit

@objc
public protocol DrawerControllerDelegate: class {

    @objc
    optional func drawerController(_ controller: DrawerController, willEndDraggingDrawer drawer: UIView, withVelocity velocity: CGFloat, targetFrame frame: UnsafeMutablePointer<CGRect>)

    @objc
    optional func drawerController(_ controller: DrawerController, bottomViewClosedFrame drawer: UIViewController?) -> CGRect

    @objc
    optional func drawerController(_ controller: DrawerController, bottomViewOpenedFrame drawer: UIViewController?) -> CGRect

}

#endif
