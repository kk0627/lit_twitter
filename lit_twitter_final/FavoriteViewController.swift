//
//  FavoriteViewController.swift
//  lit_twitter
//
//  Created by keita kutsuno on 2015/06/27.
//  Copyright (c) 2015年 keita kutsuno. All rights reserved.
//
import Foundation
import TwitterKit
import UIKit

class FavoriteViewController: BaseTweetViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set navigation title
        self.navigationItem.title = "お気に入り"
    }

    override func load() {
        TwitterAPI.getMyFavorites({
            twttrs in
            for tweet in twttrs {
                let tmptweet : TWTRTweet = tweet
                    self.tweets.append(tmptweet)
                }
            },
            error: {
            error in
            // error handling
            
        })
    }

}
