#if canImport(UIKit)

import UIKit

open class DrawerController: UIViewController {

    // MARK: - Root View Controller

    open var rootViewController: UIViewController? {
        didSet {
            replace(root: oldValue, by: rootViewController)
        }
    }

    // MARK: - Drawers

    open var bottomViewController: UIViewController? {
        didSet {
            replace(bottom: oldValue?.view, by: bottomViewController?.view)
            setNeedsUpdateOfScreenEdgesDeferringSystemGestures()
        }
    }

    // MARK: - Customization

    @IBInspectable
    open var throwVelocityThreshold: CGFloat = 500.0

    @IBInspectable
    open var throwPercentageThresfold: CGFloat = 0.3

    // MARK: - Open / Close

    open var isBottomViewOpen: Bool = false

    // MARK: - Gesture Recognizers

    open private(set) lazy var openBottomDrawerGestureRecognizer: UIScreenEdgePanGestureRecognizer = {
        let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleBottomPanGesture(_:)))
        recognizer.edges = .bottom
        recognizer.delegate = self
        self.view.addGestureRecognizer(recognizer)
        return recognizer
    }()

    open private(set) lazy var closeBottomDrawerGestureRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(handleBottomPanGesture(_:)))
        recognizer.delegate = self
        return recognizer
    }()

    // MARK: - Delegate

    weak var delegate: DrawerControllerDelegate?

    // MARK: - Drag

    var draggingOrigin: CGPoint = .zero

    var isDraggingBottomView: Bool = false

    // MARK: Preferred Screen Edges

    override open var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
        var edges: UIRectEdge = []
        if bottomViewController != nil {
            edges.insert(.bottom)
        }
        return edges
    }

    // MARK: - View lifecycle

    override open func viewDidLoad() {
        super.viewDidLoad()

        // embed drawers

        performEmbedSegues()

        // enable dragging

        enableDragging()
    }


    // MARK: - Actions

    @objc func handleBottomPanGesture(_ recognizer: UIGestureRecognizer) {
        guard let recognizer = recognizer as? UIPanGestureRecognizer else {
            return
        }

        let translation = recognizer.translation(in: self.view)
        let velocity    = recognizer.velocity(in: self.view)

        switch recognizer.state {
        case .began:
            beginBottomDragging(translation: translation, velocity: velocity)
            break
        case .changed:
            continueBottomDragging(translation: translation, velocity: velocity)
            break
        case .failed:
            print("[DrawerView] ERROR: DrawerViewPanGestureRecognizer failed.")
            fallthrough
        case .ended:
            endBottomDragging(translation: translation, velocity: velocity)
            break
        default:
            break
        }
    }
}

// MARK: - Dragging

extension DrawerController {

    open func enableDragging() {
        openBottomDrawerGestureRecognizer.isEnabled = true
    }

    open func disableDragging() {
        openBottomDrawerGestureRecognizer.isEnabled = false
    }

}


// MARK: - UIGestureRecognizerDelegate

extension DrawerController: UIGestureRecognizerDelegate {
    
}

// MARK: - Bottom View

public extension DrawerController {

}

#endif
