//
//  ApiService.swift
//  youtobe
//
//  Created by John Nik on 10/21/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
        
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            //this is old method
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//
//                var videos = [Video]()
//
//                for dictionary in json  as! [[String: AnyObject]] {
//
//                    let video = Video()
//                    video.title = dictionary["title"] as? String
//                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//                    video.numberOfViews = dictionary["number_of_views"] as? NSNumber
//
//                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
//                    let channel = Channel()
//                    channel.name = channelDictionary["name"] as? String
//                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
//
//                    video.channel = channel
//                    videos.append(video)
//
//                }
//
//                DispatchQueue.main.async {
//                    completion(videos)
//                }
//
//            } catch let jsonError {
//                print(jsonError)
//            }
            
            
            //this is new method
            
            do {
                if let unwrappedData = data, let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]] {
                    DispatchQueue.main.async {
                        completion(jsonDictionaries.map({return Video(dictionary: $0)}))
                    }
                }
            } catch let jsonError {
                print(jsonError)
            }
            
            
            }.resume()
    }
    
}




















