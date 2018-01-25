//
//  SubscriptionCell.swift
//  youtobe
//
//  Created by John Nik on 10/21/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func fetchVideo() {
        ApiService.sharedInstance.fetchSubscriptionFeed { (videos) in
            
            self.videos = videos
            self.collectionView.reloadData()
            
        }
    }
}
