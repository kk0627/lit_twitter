//
// TimelineViewController.swift
//  lit_twitter
//
//  Created by keita kutsuno on 2015/06/26.
//  Copyright (c) 2015年 keita kutsuno. All rights reserved.
//

import Foundation
import TwitterKit
import UIKit

class TimelineViewController: BaseTweetViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set navigation title
        self.navigationItem.title =  "タイムライン"
    }
    
    override func load(){

        TwitterAPI.getHomeTimeline({
            twttrs in
            for tweet in twttrs {
                let tmptweet : TWTRTweet = tweet
                if (tmptweet.text.rangeOfString("http://") != nil){
                self.tweets.append(tmptweet)
                let tweetid = tmptweet.tweetID
//                println("------kugirisen--------")
//                println(tweetid)
                }
            }
            self.tableView.reloadData()
            }, maxid: nil, count: "100", error: {
            error in
            // error handling
        })
    }
    

    
    //Editableの状態にする.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
    
    //特定の行のボタン操作を有効にする.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        println("commitEdittingStyle:\(editingStyle)")
    }
    
    //Buttonを拡張する
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        // Favoriteボタン
        var myFavoriteButton: UITableViewRowAction = UITableViewRowAction(style: .Normal, title: "後で読む") { (action, index) -> Void in
            tableView.editing = false
            let data : [TWTRTweet] = self.tweets
            println(data[indexPath.row].tweetID)
            TwitterAPI.addFavorite(data[indexPath.row].tweetID)
        }
        myFavoriteButton.backgroundColor = UIColor.lightGrayColor()
         return [myFavoriteButton]
 }
    
    
}
