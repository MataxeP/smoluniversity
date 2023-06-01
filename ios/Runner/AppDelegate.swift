import UIKit
import Flutter
import GoogleMaps
import shared_preferences_ios

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyARkbDh30O_FiKMmj-2pKApKNwENnOwj1g")
    GeneratedPluginRegistrant.register(with: self)
    SwiftAwesomeNotificationsPlugin.setPluginRegistrantCallback { registry in          
          SwiftAwesomeNotificationsPlugin.register(
            with: registry.registrar(forPlugin: "io.flutter.plugins.awesomenotifications.AwesomeNotificationsPlugin")!)          
          FLTSharedPreferencesPlugin.register(
            with: registry.registrar(forPlugin: "io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin")!)
      }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

