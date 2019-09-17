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
            guard (translation.y < 0.0 && isBottomViewClose) || (translation.y > 0.0 && isBottomViewOpen) else {
                return .zero
            }

            let newY = translation.y
            let minY = bottomViewMinDraggingPosition
            let maxY = bottomViewMaxDraggingPosition

            return abs(newY / (maxY - minY))
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
