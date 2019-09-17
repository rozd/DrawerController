//
//  File.swift
//  
//
//  Created by Max Rozdobudko on 9/9/19.
//

#if canImport(UIKit)

import UIKit

public extension DrawerController {

    var bottomView: UIView? {
        return bottomViewController?.view
    }

    var isBottomViewClose: Bool {
        return !isBottomViewOpen
    }

    // MARK: Replace view

    func replace(bottom oldViewController: UIViewController?, by newViewController: UIViewController?) {
        oldViewController?.view?.removeFromSuperview()
        oldViewController?.removeFromParent()
        oldViewController?.view?.removeGestureRecognizer(closeBottomDrawerGestureRecognizer)
        guard let newViewController = newViewController else {
            return
        }
        newViewController.willMove(toParent: self)
        newViewController.view.frame = oldViewController?.view.frame ?? bottomViewCurrentFrame
        newViewController.view.addGestureRecognizer(closeBottomDrawerGestureRecognizer)
        view.addSubview(newViewController.view)
        addChild(newViewController)
        newViewController.didMove(toParent: self)
    }

    // MARK: Open / Close

    func openBottomViewController(animated: Bool, completion: ((Bool) -> ())? = nil) {
        guard isBottomViewClose else {
            completion?(true)
            return
        }

        let duration = animated ? 0.337 : 0.0

        let animations = { [unowned self] in
            self.isBottomViewOpen = true
        }

        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }

    func closeBottomViewController(animated: Bool, completion: ((Bool) -> ())? = nil) {
        guard isBottomViewOpen else {
            completion?(true)
            return
        }

        let duration = animated ? 0.337 : 0.0

        let animations = { [unowned self] in
            self.isBottomViewOpen = false
        }

        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }

    // MARK: Update Frame

    var bottomViewClosedFrame: CGRect {
        guard let viewController = bottomViewController else {
            return .zero
        }
        return delegate?.drawerController?(self, closedFrameForBottomDrawer: viewController) ??
            self.view.bounds.applying(CGAffineTransform(translationX: 0.0, y: self.view.bounds.height))
    }

    var bottomViewOpenedFrame: CGRect {
        guard let viewController = bottomViewController else {
            return .zero
        }
        return delegate?.drawerController?(self, openedFrameForBottomDrawer: viewController) ??
            self.view.bounds
    }

    var bottomViewCurrentFrame: CGRect {
        if isBottomViewOpen {
            return bottomViewOpenedFrame
        } else {
            return bottomViewClosedFrame
        }
    }

    func updateBottomDrawerFrame() {
        bottomView?.frame = bottomViewCurrentFrame
    }

    // MARK: Dragging

    var bottomViewMinDraggingPosition: CGFloat {
        guard let vc = bottomViewController else {
            return .zero
        }
        return delegate?.drawerController?(self, minDraggingPositionForBottomDrawer: vc) ?? .zero
    }

    var bottomViewMaxDraggingPosition: CGFloat {
        guard let vc = bottomViewController else {
            return .zero
        }
        return delegate?.drawerController?(self, maxDraggingPositionForBottomDrawer: vc) ?? view.bounds.height
    }

    func beginBottomDragging(location: CGPoint, translation: CGPoint, velocity: CGPoint) {
        guard bottomView != nil else {
            return
        }

        draggingOrigin = location

        isDraggingBottomView = true
    }

    func continueBottomDragging(translation: CGPoint, velocity: CGPoint) {
        guard let bottomView = bottomView, isDraggingBottomView else {
            return
        }

        let closedFrame = bottomViewClosedFrame
        let openedFrame = bottomViewOpenedFrame

        let progress = self.progress(forTranslation: translation)

        if isBottomViewOpen {
            bottomView.frame = self.frame(from: openedFrame, to: closedFrame, with: progress)
        } else {
            bottomView.frame = self.frame(from: closedFrame, to: openedFrame, with: progress)
        }

    }

    func endBottomDragging(translation: CGPoint, velocity: CGPoint) {
        guard let bottomView = bottomView, isDraggingBottomView else {
            return
        }

        let progress = self.progress(forTranslation: translation)

        isDraggingBottomView = false

        let velocity = velocity.y * (isBottomViewOpen ? 1.0 : -1.0)

        let distance = draggingOrigin.y - bottomView.frame.origin.y
        let springVelocity = max(1 / (abs(velocity / distance)), 0.08)


        let accomplishAnimations = { [unowned self] in
            self.isBottomViewOpen = !self.isBottomViewOpen
        }

        let springBackAnimations = { [unowned self] in
            bottomView.frame = self.bottomViewCurrentFrame
        }

        if progress > throwPercentageThresfold || velocity > throwVelocityThreshold {
            UIView.animate(withDuration: 0.337,
                           delay: 0.0,
                           usingSpringWithDamping: 1.0,
                           initialSpringVelocity: springVelocity,
                           options: [.curveLinear],
                           animations: accomplishAnimations,
                           completion: nil)
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0.0,
                           usingSpringWithDamping: 1.0,
                           initialSpringVelocity: springVelocity,
                           options: [.curveLinear],
                           animations: springBackAnimations,
                           completion: nil)
        }
    }
}

#endif
