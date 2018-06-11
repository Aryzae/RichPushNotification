//
//  NotificationViewController.swift
//  NotificationExtension
//
//  Created by Sho Ito on 2018/06/08.
//  Copyright © 2018年 Aryzae. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import WebKit

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        guard let notificationData = notification.request.content.userInfo["notification-data"] as?
        [String : String] else { return }
        let url = notificationData["attachment-url"]!

        webView.load(URLRequest.init(url: URL.init(string: url)!))

    }

}
