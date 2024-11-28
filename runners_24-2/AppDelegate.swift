import UIKit
import NMapsMap

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 클라이언트 ID 설정
        NMFAuthManager.shared().clientId = "egugv1onne"
        return true
    }
}
