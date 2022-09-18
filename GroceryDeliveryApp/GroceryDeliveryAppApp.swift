//
//  GroceryDeliveryAppApp.swift
//  GroceryDeliveryApp
//
//  Created by Batikan Sosun on 13.08.2022.
//

import SwiftUI
import Foundation

@main
struct GroceryDeliveryAppApp: App {
    
    let center = UNUserNotificationCenter.current()
    
    init() {
        registerForNotification()
    }
    
    func registerForNotification() {
        UIApplication.shared.registerForRemoteNotifications()
        let center : UNUserNotificationCenter = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound , .alert , .badge ], completionHandler: { (granted, error) in
            if ((error != nil)) { UIApplication.shared.registerForRemoteNotifications() }
            else {
                
            }
        })
    }
    
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.1, *) {
                ContentView().onOpenURL { url in
                    guard let url = URLComponents(string: url.absoluteString) else { return }
                    if let courierNumber = url.queryItems?.first(where: { $0.name == "CourierNumber" })?.value {
                        // call courier
                    }
                }
            }
        }
    }
}


