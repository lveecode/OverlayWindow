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
        shared.displayingWindow?.accessibilityViewIsModal = true
        shared.displayingWindow?.rootViewController = controller
        
        display(window: shared.displayingWindow!)
    }
    
    
    /// Dismiss overlay window
    ///
    /// - Parameter completion: A block to be performed after the window was dismissed
    @objc public static func dismissOverlayWindow(completion: (()->Void)? = nil) {
        dismissWindown(shared.displayingWindow, completion: {
            shared.displayingWindow = nil
            completion?()
        })
    }
    
    @objc public static func dismissWindown(_ window: UIWindow?, completion: (()->Void)? = nil) {
        guard let window = window else {
            completion?()
            return
        }
        
        // Dismissing modals, if any
        if window.rootViewController?.presentedViewController != nil {
            window.rootViewController?.dismiss(animated: true, completion: {})
        }
        
        UIView.animate(withDuration: 0.2,
                       animations: {
            window.alpha = 0 },
                       completion: { (finished) in
            // Precaution to ensure window gets destroyed
            window.isHidden = true
            completion?()
        })
    }
    
    @objc public static func display(window: UIWindow) {
        // Window level will be set to 'above the current top window' (this makes the alert, if it's a sheet, show over the keyboard)

        // Pre-UIWindowScene approach as a default
        let topWindow = UIApplication.shared.windows.last
        var windowLevel = UIWindow.Level(rawValue: topWindow?.windowLevel.rawValue ?? 0 + 1)
        
        if #available(iOS 13.0, *) {
            // If the app is using UIWindowScene lifecycle
            if let windowScene = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first(where: { $0.activationState == .foregroundActive }),
               let topWindow = windowScene.windows.last {
                windowLevel = UIWindow.Level(rawValue: topWindow.windowLevel.rawValue + 1)
                window.windowScene = windowScene
            }
        }
        
        if (windowLevel.rawValue == 0) {
            // Just in case we still failed to calculate windowLevel
            windowLevel = UIWindow.Level.alert
        }
        
        // If we somehow got to status bar level, go under it
        window.windowLevel = min(windowLevel, UIWindow.Level.statusBar - 1)
        
        window.makeKeyAndVisible()
        
        // Animate fade in
        window.alpha = 0
        UIView.animate(withDuration: 0.2) {
            window.alpha = 1
        }
    }
}
