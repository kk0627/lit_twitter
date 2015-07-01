//
//  LoginViewController.swift
//  lit_twitter
//
//  Created by keita kutsuno on 2015/06/26.
//  Copyright (c) 2015年 keita kutsuno. All rights reserved.
//


import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = TWTRLogInButton(logInCompletion: {
            session, error in
            if session != nil {
                println(session.userName)
                // ログイン成功したらする
                let timelineVC = MainTabViewController()
                UIApplication.sharedApplication().keyWindow?.rootViewController = timelineVC
            } else {
                println(error.localizedDescription)
            }
        })
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }
}
