//
//  DrawerControllerDelegate+Utils.swift
//  
//
//  Created by Max Rozdobudko on 9/10/19.
//

#if canImport(UIKit)

import UIKit

public extension DrawerController {

    func progress(forTranslation translation: CGPoint) -> CGFloat {
        if isDraggingBottomView {

            let minY = bottomViewOpenedFrame.origin.y
            let maxY = bottomViewClosedFrame.origin.y

            var newY = draggingOrigin.y + translation.y
            newY = min(maxY, newY)
            newY = max(minY, newY)

            var progress = newY / (maxY - minY)
            if !isBottomViewOpen {
                progress = 1 - progress
            }

            return progress
        }
        return .zero
    }

    func frame(from start: CGRect, to end: CGRect, with progress: CGFloat) -> CGRect {
        return CGRect(x: start.minX + (end.minX - start.minX) * progress,
                      y: start.minY + (end.minY - start.minY) * progress,
                      width: start.width + (end.width - start.width) * progress,
                      height: start.height + (end.height - start.height) * progress)
    }
}

#endif
