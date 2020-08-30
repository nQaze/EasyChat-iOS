//
//  RegistrationVC.swift
//  EasyChat-iOS
//
//  Created by Nabil Kazi on 30/08/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import UIKit
import CometChatPro

class RegistrationVC: UIViewController {
    
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signInBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        let uid = "\(nameTextField.text!.first!)\(mobileTextField.text!)"
        registerUser(uid: uid , name: nameTextField.text!)
    }
    
    private func registerUser(uid: String, name: String){
        showActivityIndicator()
        let newUser : User = User(uid: uid, name: name)
        CometChat.createUser(user: newUser, apiKey: Constants.apiKey, onSuccess: { (User) in
            print("User created successfully. \(User.stringValue())")
            self.hideActivityIndicator()
            if CometChat.getLoggedInUser() == nil {
                self.loginUser(uid: uid)
            }
          }) { (error) in
            print("The error is \(String(describing: error?.errorDescription))")
            self.hideActivityIndicator()
        }
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
