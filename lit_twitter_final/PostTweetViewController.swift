//
//  PostTweetViewController.swift
//  lit_twitter_final
//
//  Created by keita kutsuno on 2015/06/27.
//  Copyright (c) 2015年 keita kutsuno. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

class PostTweetViewController: UIViewController,UITextFieldDelegate{
    
    var myTextField:UITextField!
    var navigationLeftButton:UIButton!
    var navigationRightButton:UIButton!
    var myImageView:UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set navigation title
        self.navigationItem.title =  "Tweet"
        
        //ナビゲーションバーの左ボタンを設計(バツボタン)
        navigationLeftButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        navigationLeftButton.addTarget(self, action: "onClickLeftButton:", forControlEvents: .TouchUpInside)
        navigationLeftButton.frame = CGRectMake(0,0,24,24)
        navigationLeftButton.setImage(UIImage(named: "batsu.png"), forState: .Normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationLeftButton)

        //ナビゲーションバーの左ボタンを設計(ツイートボタン)
        navigationRightButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        navigationRightButton.addTarget(self, action: "onClickRightButton:", forControlEvents: .TouchUpInside)
        navigationRightButton.frame = CGRectMake(0,0,24,24)
        navigationRightButton.setImage(UIImage(named: "postTweet.png"), forState: .Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigationRightButton)

        
        self.view.backgroundColor = UIColor.whiteColor()
        
        //textFieldの生成
        myTextField = UITextField(frame: CGRectMake(0,0,300,200))
        myTextField.placeholder = "ツイートをしましょう"
        myTextField.returnKeyType = UIReturnKeyType.Done
        myTextField.borderStyle = UITextBorderStyle.RoundedRect
        myTextField.layer.position = CGPointMake(self.view.frame.width/2, 200)
        myTextField.delegate = self
        self.view.addSubview(myTextField)
        
        myImageView = UIImageView(frame: CGRectMake(0,0,300,200))
        myImageView.image = UIImage(named: "syuzo.jpeg")
        myImageView.layer.position = CGPointMake(self.view.frame.width/2, 450)
        
        
    }
    
    //完了を押したらキーボードを閉じる
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        println("return")
        if textField.isFirstResponder() {
            textField.resignFirstResponder()
        }
        return true
    }
    
    //tweetをポストする
    func postTweet(tweetText: String!, replyid: String!){
        TwitterAPI.postTweet(
            tweetText,
            in_reply_to_status_id: nil,
            mediaids: nil,
            error: {
                error in
                println(error.localizedDescription)
        })
        
    }
    
    
    func onClickLeftButton(sender:UIButton){
        dismissViewControllerAnimated(true, completion: nil)
    }

    func onClickRightButton(sender:UIButton){
        if myTextField.text.rangeOfString("http") != nil {
            postTweet(myTextField.text,replyid: nil)
            dismissViewControllerAnimated(true, completion: nil)
        } else{
            println(myTextField.text)
            self.view.addSubview(myImageView)
            self.view.backgroundColor = UIColor.redColor()
        }
    }
    
    
    
}