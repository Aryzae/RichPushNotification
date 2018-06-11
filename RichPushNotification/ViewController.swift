//
//  ViewController.swift
//  RichPushNotification
//
//  Created by Sho Ito on 2018/06/01.
//  Copyright © 2018年 Aryzae. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var title1TextField: UITextField!
    @IBOutlet weak var message1TextField: UITextField!
    @IBOutlet weak var threadID1TextField: UITextField!
    @IBOutlet weak var summaryArg1TextField: UITextField!

    @IBOutlet weak var title2TextField: UITextField!
    @IBOutlet weak var message2TextField: UITextField!
    @IBOutlet weak var threadID2TextField: UITextField!
    @IBOutlet weak var summaryArg2TextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func touchUpInsideFireButton(_ sender: UIButton) {
        requestNotify1()
        requestNotify2()
    }

    func requestNotify1() {
        let content = UNMutableNotificationContent()
        // セット
        content.title = title1TextField.text ?? ""
        content.body = message1TextField.text ?? ""
        content.threadIdentifier = threadID1TextField.text ?? ""
        if #available(iOS 12.0, *) {
            content.summaryArgument = summaryArg1TextField.text ?? ""
        }
        // トリガー
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 10, repeats: false)
        // リクエスト
        let request = UNNotificationRequest.init(identifier: UUID().uuidString, content: content, trigger: trigger)
        // 発火
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    func requestNotify2() {
        let content = UNMutableNotificationContent()
        // セット
        content.title = title2TextField.text ?? ""
        content.body = message2TextField.text ?? ""
        content.threadIdentifier = threadID2TextField.text ?? ""
        if #available(iOS 12.0, *) {
            content.summaryArgument = summaryArg2TextField.text ?? ""
        }
        // トリガー
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 10, repeats: false)
        // リクエスト
        let request = UNNotificationRequest.init(identifier: UUID().uuidString, content: content, trigger: trigger)
        // 発火
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

    @objc
    func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let scrennSize: CGSize = UIScreen.main.bounds.size
        let txtLimit: CGFloat = scrollView.frame.origin.y + scrollView.frame.height + 8.0
        let kbdLimit = scrennSize.height - keyboardFrame.size.height

        if txtLimit >= kbdLimit {
            scrollView.contentOffset.y = txtLimit - kbdLimit
        }
    }

    @objc
    func keyboardWillHide(notification: Notification) {
        scrollView.contentOffset.y = 0
    }
}

extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
