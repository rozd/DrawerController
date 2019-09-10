//
//  DrawerControllerDelegate+RootView.swift
//  
//
//  Created by Max Rozdobudko on 9/10/19.
//

#if canImport(UIKit)

import UIKit

public extension DrawerController {

    func replace(root oldViewController: UIViewController?, by newViewController: UIViewController?) {
        oldViewController?.removeFromParent()
        oldViewController?.view.removeFromSuperview()
        guard let newViewController = newViewController else {
            return
        }
        newViewController.willMove(toParent: self)
        addChild(newViewController)
        view.insertSubview(newViewController.view, at: 0)
        newViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            newViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            newViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            newViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        ])
        newViewController.didMove(toParent: self)
    }

}

#endif
