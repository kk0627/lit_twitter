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
                if (tmptweet.text.rangeOfString("http://") != nil) && (//(tmptweet.description.rangeOfString("@hatebu") != nil) ||
                                                                        (tmptweet.description.rangeOfString("@logmijp") != nil) ||
                                                                        (tmptweet.description.rangeOfString("@hr_nabi") != nil) ||
                                                                        //(tmptweet.description.rangeOfString("@blxxll") != nil) ||
                                                                        (tmptweet.description.rangeOfString("@kotosaka") != nil) ||
                                                                        (tmptweet.description.rangeOfString("@forbesjapan") != nil) ||
                                                                        (tmptweet.description.rangeOfString("@tabbata") != nil) ||
                                                                        (tmptweet.description.rangeOfString("@hidenorigoto") != nil) ||
                                                                        (tmptweet.description.rangeOfString("@iteman") != nil) ||
                                                                        (tmptweet.description.rangeOfString("@dentsuho") != nil) ||
                                                                        (tmptweet.description.rangeOfString("@shin1x1") != nil) ||
                                                                        (tmptweet.description.rangeOfString("@NewsPicksZebra") != nil) ||
                                                                        (tmptweet.description.rangeOfString("@norihiko_sasaki") != nil)

                    ){
                //if tmptweet.text.rangeOfString("http://") != nil{
                self.tweets.append(tmptweet)
                let tweetid = tmptweet.tweetID
                println("------kugirisen--------")
                println(tmptweet)
                }
            }
            self.tableView.reloadData()
            }, maxid: nil, count: "500", error: {
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
