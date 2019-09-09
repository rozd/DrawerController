//
//  File.swift
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
}

#endif
