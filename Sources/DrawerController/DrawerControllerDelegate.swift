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

    // MARK: Bottom Drawer

    @objc
    optional func drawerController(_ controller: DrawerController, willEndDraggingDrawer drawer: UIView, withVelocity velocity: CGFloat, targetFrame frame: UnsafeMutablePointer<CGRect>)

    @objc
    optional func drawerController(_ controller: DrawerController, closedFrameForBottomDrawer drawer: UIViewController?) -> CGRect

    @objc
    optional func drawerController(_ controller: DrawerController, openedFrameForBottomDrawer drawer: UIViewController?) -> CGRect

    @objc
    optional func drawerController(_ controller: DrawerController, minDraggingPositionForBottomDrawer drawer: UIViewController?) -> CGFloat

    @objc
    optional func drawerController(_ controller: DrawerController, maxDraggingPositionForBottomDrawer drawer: UIViewController?) -> CGFloat

}

#endif
