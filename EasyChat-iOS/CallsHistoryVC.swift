//
//  CallsHistoryVC.swift
//  EasyChat-iOS
//
//  Created by Nabil Kazi on 30/08/20.
//  Copyright © 2020 Nabil Kazi. All rights reserved.
//

import UIKit
import CometChatPro

class CallsHistoryListVC: CometChatCallsList {

    static func storyboardInstance() -> CallsHistoryListVC? {
        let storyboard = UIStoryboard(name: "Main" ,bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "CallsHistoryListVC") as? CallsHistoryListVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
