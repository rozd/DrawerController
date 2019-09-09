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
        guard let view = bottomView else {
            return .zero
        }
        return delegate?.drawerController?(self, closedFrameForDrawer: view) ?? .zero
    }

    var bottomViewOpenedFrame: CGRect {
        guard let view = bottomView else {
            return .zero
        }
        return delegate?.drawerController?(self, openedFrameForDrawer: view) ?? .zero
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

        let minY = openedFrame.origin.y
        let maxY = closedFrame.origin.y
        let rangeY = maxY - minY

        var newY = draggingOrigin.y + translation.y
        newY = min(maxY, newY)
        newY = max(minY, newY)

        let progress = newY / rangeY

        var frame: CGRect = .zero

        if isBottomViewOpen {
            frame = CGRect(x: closedFrame.minX + (openedFrame.minX - closedFrame.minX) * progress,
                           y: closedFrame.minY + (openedFrame.minY - closedFrame.minY) * progress,
                           width: closedFrame.width + (openedFrame.width - closedFrame.width) * progress,
                           height: closedFrame.height + (openedFrame.height - closedFrame.height) * progress)
        } else {
            frame = CGRect(x: openedFrame.minX + (closedFrame.minX - openedFrame.minX) * progress,
                           y: openedFrame.minY + (closedFrame.minY - openedFrame.minY) * progress,
                           width: openedFrame.width + (closedFrame.width - openedFrame.width) * progress,
                           height: openedFrame.height + (closedFrame.height - openedFrame.height) * progress)
        }

        bottomView.frame = frame

    }

    func endBottomDragging(translation: CGPoint, velocity: CGPoint) {
        guard let bottomView = bottomView, isDraggingBottomView else {
            return
        }

        isDraggingBottomView = false

        let closedFrame = bottomViewClosedFrame
        let openedFrame = bottomViewOpenedFrame

        let minY = openedFrame.origin.y
        let maxY = closedFrame.origin.y

        var newY = draggingOrigin.y + translation.y
        newY = min(maxY, newY)
        newY = max(minY, newY)

        let progress = newY / (maxY - minY)

        if progress > throwPercentageThresfold || abs(velocity.y) > throwVelocityThreshold {
            isBottomViewOpen = !isBottomViewOpen
        }

        let frame = isBottomViewOpen ? bottomViewOpenedFrame : bottomViewClosedFrame

        UIView.animate(withDuration: 0.25) {
            bottomView.frame = frame
        }

    }
}

#endif
