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
    optional func drawerController(_ controller: DrawerController, closedPositionForDrawer drawer: UIView) -> CGPoint

    @objc
    optional func drawerController(_ controller: DrawerController, openedPositionForDrawer drawer: UIView) -> CGPoint

    @objc
    optional func drawerController(_ controller: DrawerController, closedFrameForDrawer drawer: UIView) -> CGRect

    @objc
    optional func drawerController(_ controller: DrawerController, openedFrameForDrawer drawer: UIView) -> CGRect

    @objc
    optional func drawerController(_ controller: DrawerController, willEndDraggingDrawer drawer: UIView, withVelocity velocity: CGFloat, targetFrame frame: UnsafeMutablePointer<CGRect>)

//    @objc
//    optional func drawerController(_ controller: DrawerController, finalPosition sides: [UIRectEdge: CGFloat])
}

#endif
