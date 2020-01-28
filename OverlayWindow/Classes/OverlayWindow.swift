//  Copyright © 2019 LVeecode. All rights reserved.
//

import UIKit

@objc public class OverlayWindow: NSObject {
    
    @objc public static let shared = OverlayWindow()
    
    @objc public var displayingWindow: UIWindow? = nil
    
    /// Creates a new window on top of the existing ones
    /// and displayes your controller in it
    ///
    /// - Parameter controller: Controller to display in an overlay window
    @objc public static func presentOverlayWindow(withController controller: UIViewController) {
        shared.displayingWindow = UIWindow(frame: UIScreen.main.bounds)
        shared.displayingWindow?.rootViewController = controller
        
        display(window: shared.displayingWindow!)
    }
    
    
    /// Dismiss overlay window
    ///
    /// - Parameter completion: A block to be performed after the window was dismissed
    @objc public static func dismissOverlayWindow(completion: (()->Void)? = nil) {
        
        if shared.displayingWindow == nil {
            completion?()
            return
        }
        
        // Dismissing modals, if any
        if shared.displayingWindow?.rootViewController?.presentedViewController != nil {
            shared.displayingWindow?.rootViewController?.dismiss(animated: true, completion: {})
        }
        
        UIView.animate(withDuration: 0.2,
                       animations: {
                        shared.displayingWindow?.alpha = 0
        },
                       completion: { (finished) in
                        // Precaution to insure window gets destroyed
                        shared.displayingWindow?.isHidden = true
                        shared.displayingWindow = nil
                        
                        completion?()
        })
    }
    
    private static func display(window: UIWindow) {
        // Window level is above the top window (this makes the alert, if it's a sheet, show over the keyboard)
        let topWindow = UIApplication.shared.windows.last
        window.windowLevel = UIWindow.Level(rawValue: topWindow?.windowLevel.rawValue ?? 0 + 1)
        
        if window.windowLevel >= UIWindow.Level.statusBar {
            window.windowLevel = UIWindow.Level.statusBar - 1
        }
        
        window.makeKeyAndVisible()
        
        // Animate fade in
        window.alpha = 0
        UIView.animate(withDuration: 0.2) {
            window.alpha = 1
        }
    }
}

