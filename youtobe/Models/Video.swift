//
//  Video.swift
//  youtobe
//
//  Created by John Nik on 10/10/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import UIKit

// this is for new method in api service
class SafeJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        
        let uppercasedFirstCharacter = String(key.characters.first!).uppercased()
        
        let range = NSMakeRange(0, 1)
        let selectorString = NSString(string: key).replacingCharacters(in: range, with: uppercasedFirstCharacter)
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
        if !responds {
            return
        }
        super.setValue(value, forKey: key)
        
    }
}

class Video: NSObject {
    @objc var thumbnail_image_name: String?
    @objc var title: String?
    @objc var number_of_views: NSNumber?
    @objc var uploadDate: Date?
    @objc var duration: NSNumber?
    @objc var channel: Channel?
    
    
    // this is for new method in api service
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "channel" {
            self.channel = Channel()
            self.channel?.setValuesForKeys(value as! [String: AnyObject])
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
    
}

class Channel: NSObject {
    @objc var name: String?
    @objc var profile_image_name: String?
}
