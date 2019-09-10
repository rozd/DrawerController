//
//  DrawerControllerDelegate+Segues.swift
//  
//
//  Created by Max Rozdobudko on 9/9/19.
//

#if canImport(UIKit)

import UIKit

extension DrawerController {

     func performEmbedSegues() {
        guard let templates = self.value(forKey: "storyboardSegueTemplates") as? [NSObject] else {
            return
        }

        for template in templates {
            guard let segueClassName = template.value(forKey: "segueClassName") as? String else {
                continue
            }

            if segueClassName.hasSuffix("EmbedAsRootSegue") {
                template.setValue(EmbedAsRootSegue.identifier, forKey: "identifier")
                self.performSegue(withIdentifier: EmbedAsRootSegue.identifier, sender: nil)
            }
            if segueClassName.hasSuffix("EmbedAtBottomSegue") {
                template.setValue(EmbedAtBottomSegue.identifier, forKey: "identifier")
                self.performSegue(withIdentifier: EmbedAtBottomSegue.identifier, sender: nil)
            }
        }
    }

}

open class EmbedAtBottomSegue: UIStoryboardSegue {

    open class var identifier: String {
        return "drawerControllerEmbedAtBottom"
    }

    override open func perform() {
        guard let drawer = source as? DrawerController else {
            assertionFailure("Type of `source` view controller must be `DrawerViewController`.")
            return
        }
        drawer.bottomViewController = destination
    }

}

open class EmbedAsRootSegue: UIStoryboardSegue {

    open class var identifier: String {
        return "drawerControllerEmbedAsRoot"
    }

    override open func perform() {
        guard let drawer = source as? DrawerController else {
            assertionFailure("Type of `source` view controller must be `DrawerViewController`.")
            return
        }
        drawer.rootViewController = destination
    }

}

#endif
