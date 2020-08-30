//
//  ConversationsVC.swift
//  EasyChat-iOS
//
//  Created by Nabil Kazi on 30/08/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import UIKit
import CometChatPro

class ConversationsVC: CometChatConversationList {
    
    @IBOutlet weak var newChatButton: UIButton!
    
    static func storyboardInstance() -> ConversationsVC? {
        let storyboard = UIStoryboard(name: "Main" ,bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ConversationsVC") as? ConversationsVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        newChatButton.superview?.bringSubviewToFront(newChatButton)
    }
    
    @IBAction func newChatTapped(_ sender: Any) {
        openContactsList()
    }
    
    private func openContactsList(){
        DispatchQueue.main.async {
            let userList = CometChatUserList()
             userList.set(title:"Contacts", mode: .automatic)
            let navigationController = UINavigationController(rootViewController:userList)
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.window?.rootViewController = navigationController
            }
        }
    }
    
}
