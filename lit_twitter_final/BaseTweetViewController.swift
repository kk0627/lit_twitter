//
//  BaseViewController.swift
//  lit_twitter
//
//  Created by keita kutsuno on 2015/06/27.
//  Copyright (c) 2015年 keita kutsuno. All rights reserved.
//

import Foundation
import UIKit
import TwitterKit

class BaseTweetViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    var settingLeftButton: UIButton!
    
    //tweetdataを格納する配列
    var tweets: [TWTRTweet] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    //tweetを格納するセル
    var prototypeCell: TWTRTweetTableViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ナビゲーションバーの左ボタンを設計(投稿ボタン)
        var settingRightButton:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        settingRightButton.addTarget(self, action: "onClickRightButton:", forControlEvents: .TouchUpInside)
        settingRightButton.frame = CGRectMake(0,0,24,24)
        settingRightButton.setImage(UIImage(named: "post.png"), forState: .Normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingRightButton)
        
        //ナビゲーションバーの右ボタンを設計(リロードボタン)
        settingLeftButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        settingLeftButton.addTarget(self, action: "onClickLeftButton:", forControlEvents: .TouchUpInside)
        settingLeftButton.frame = CGRectMake(0,0,24,24)
        settingLeftButton.setImage(UIImage(named: "reload.png"), forState: .Normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingLeftButton)


        
        //共通ヘッダーのタイトルを仮置き（それぞれのViewControllerで設定）
        self.navigationItem.title = "title"
        
        //tableViewのサイズを画面いっぱいに
        tableView = UITableView(frame: self.view.bounds)
        
        //tableViewをdelegateとdatasourceと繋げる
        tableView.delegate = self
        tableView.dataSource = self
        
        // tableで使用するcellのクラスを指定する
        prototypeCell = TWTRTweetTableViewCell(style: .Default, reuseIdentifier: "cell")
        
        tableView.registerClass(TWTRTweetTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        // initial load
        self.load()
    }
    
    // for override
    func load(){
    }
    

    
    //セルの総数を返す
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of Tweets.
        return tweets.count
    }
    
    //セルに値を格納する
    /*
    APIのレスポンスで得られたTWTRTweetの配列をtweetsという変数にセットして、Fabricが提供するUITableViewCellを継承した
    TWTRTweetTableViewCellに各tweetsのデータを渡す(configureWithTweet)。
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! TWTRTweetTableViewCell
        
        let tweet = tweets[indexPath.row]
        cell.configureWithTweet(tweet)
        
        return cell
    }
    
    
    //セルの高さを決める
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let tweet = tweets[indexPath.row]
        
        prototypeCell?.configureWithTweet(tweet)
        
        let height :CGFloat! = TWTRTweetTableViewCell.heightForTweet(tweet, width: CGRectGetWidth(self.view.bounds))
        
        if height != nil{
            return height
        } else {
            return tableView.estimatedRowHeight
        }
    }
    
    func onClickRightButton(sender:UIButton){

        let postTweetViewController: UIViewController = PostTweetViewController()
        let modalView = UINavigationController(rootViewController: postTweetViewController)
        modalView.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
        self.presentViewController(modalView, animated: true, completion: nil)
        
        
        }
    
    func onClickLeftButton(sender:UIButton){
        UIView.animateWithDuration(0.5,
            animations:{() -> Void in
                
                // 拡大用アフィン行列を作成する.
                self.settingLeftButton.transform = CGAffineTransformMakeScale(0.3, 0.3)
                
                // 縮小用アフィン行列を作成する.
                self.settingLeftButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
                
        })
        
        self.tableView.reloadData()
    }
    
}
