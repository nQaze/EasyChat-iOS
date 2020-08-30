//
//  LoginVC.swift
//  EasyChat-iOS
//
//  Created by Nabil Kazi on 30/08/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import UIKit
import CometChatPro

class LoginVC: UIViewController {
    
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signInBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        loginUser(uid: mobileTextField.text!)
    }
    
    private func loginUser(uid: String){
        showActivityIndicator()
        CometChat.login(UID: uid, apiKey: Constants.apiKey, onSuccess: { (user) in
            print("Login successful : " + user.stringValue())
            self.hideActivityIndicator()
            self.openCalls()
        }) { (error) in
            print("Login failed with error: " + error.errorDescription);
            self.hideActivityIndicator()
        }
    }
    
    private func openChats(){
        DispatchQueue.main.async {
            let conversationList = ConversationsVC.storyboardInstance()
            conversationList!.set(title:"Chats", mode: .automatic)
            let navigationController = UINavigationController(rootViewController:conversationList!)
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.window?.rootViewController = navigationController
            }
        }
    }
    
    private func openCalls(){
        DispatchQueue.main.async {
            let callsList = CallsHistoryListVC.storyboardInstance()
            callsList!.set(title:"Calls", mode: .automatic)
            let navigationController = UINavigationController(rootViewController:callsList!)
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.window?.rootViewController = navigationController
            }
        }
    }
    
    private func showActivityIndicator(){
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    private func hideActivityIndicator(){
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }

}
