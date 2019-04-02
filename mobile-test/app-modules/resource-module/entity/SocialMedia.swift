//
//  SocialMedia.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation
import ObjectMapper

private let socialMedia_youtubeChannel = "youtubeChannel"
private let socialMedia_twitter = "twitter"
private let socialMedia_facebook = "facebook"


class SocialMedia: Mappable{
    
    internal var youtubeChannel:[String]?
    internal var twitter:[String]?
    internal var facebook:[String]?
    
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        youtubeChannel <- map[socialMedia_youtubeChannel]
        twitter <- map[socialMedia_twitter]
        facebook <- map[socialMedia_facebook]
        
    }
}
