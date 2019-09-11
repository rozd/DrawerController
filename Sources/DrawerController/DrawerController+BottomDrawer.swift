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

    var bottomViewClosedFrame: CGRect {
        guard let viewController = bottomViewController else {
            return .zero
        }
        return delegate?.drawerController?(self, bottomViewClosedFrame: viewController) ?? defaultBottomViewClosedFrame
    }

    fileprivate var defaultBottomViewClosedFrame: CGRect {
        return self.view.bounds.applying(CGAffineTransform(translationX: 0.0, y: self.view.bounds.height))
    }

    var bottomViewOpenedFrame: CGRect {
        guard let viewController = bottomViewController else {
            return .zero
        }
        return delegate?.drawerController?(self, bottomViewOpenedFrame: viewController) ?? defaultBottomViewOpenedFrame
    }

    fileprivate var defaultBottomViewOpenedFrame: CGRect {
        return self.view.bounds
    }

    func replace(bottom oldView: UIView?, by newView: UIView?) {
        oldView?.removeFromSuperview()
        oldView?.removeGestureRecognizer(closeBottomDrawerGestureRecognizer)
        guard let newView = newView else {
            return
        }
        newView.frame = oldView?.frame ?? bottomViewClosedFrame
        newView.addGestureRecognizer(closeBottomDrawerGestureRecognizer)
        view.addSubview(newView)
    }

    func beginBottomDragging(translation: CGPoint, velocity: CGPoint) {
        guard let bottomView = bottomView else {
            return
        }

        draggingOrigin = bottomView.frame.origin

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

        if progress > throwPercentageThresfold || velocity > throwVelocityThreshold {
            isBottomViewOpen = !isBottomViewOpen
        }

        var frame = isBottomViewOpen ? bottomViewOpenedFrame : bottomViewClosedFrame

        let distance = draggingOrigin.y - bottomView.frame.origin.y
        let springVelocity = max(1 / (abs(velocity / distance)), 0.08)

        delegate?.drawerController?(self, willEndDraggingDrawer: bottomView, withVelocity: springVelocity, targetFrame: &frame)

        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 1.0,
                       initialSpringVelocity: springVelocity,
                       options: [.curveLinear],
                       animations: {
                           bottomView.frame = frame
                       }, completion: nil)
    }
}

#endif
