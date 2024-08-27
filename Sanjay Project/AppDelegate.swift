import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }
    
    // MARK: - UISceneSession Lifecycle (iOS 13+)
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Return a configuration for creating a new scene with
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session
        print("Scene sessions discarded: \(sceneSessions)")
    }
    
    // MARK: - Application State Transitions
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused or not yet started while the app was inactive
        print("App did become active")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Pause ongoing tasks or disable features that should not run while the app is inactive
        print("App will resign active")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Release shared resources, save user data, and store enough state to restore the app
        print("App did enter background")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Undo the changes made on entering the background
        print("App will enter foreground")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Perform any final cleanup before the app is terminated
        print("App will terminate")
    }
    
    // MARK: - Handling Remote Notifications
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Forward the device token to your server to use for push notifications
        print("Did register for remote notifications with device token: \(deviceToken)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Handle failure to register for remote notifications
        print("Failed to register for remote notifications: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Handle receiving a remote notification
        print("Did receive remote notification: \(userInfo)")
        completionHandler(.newData)
    }
    
    // MARK: - Handling URL Schemes and Universal Links
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Handle opening a URL
        print("App opened with URL: \(url)")
        return true
    }
    
    // MARK: - State Restoration
    
    func application(_ application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        // Determine whether to save the app state
        return true
    }
    
    func application(_ application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        // Determine whether to restore the app state
        return true
    }
    
    func application(_ application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
        // Return the view controller corresponding to the specified restoration path
        print("Restoring view controller with path: \(identifierComponents)")
        return nil
    }
    
    // MARK: - Background Fetch
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Perform background fetch and call the completion handler
        print("Performing background fetch")
        completionHandler(.newData)
    }
}
