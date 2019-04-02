//
//  GPS.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation
import ObjectMapper

private let gps_latitude = "latitude"
private let gps_longitude = "longitude"


class GPS: Mappable{
    
    internal var latitude:String?
    internal var longitude:String?
    
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        latitude <- map[gps_latitude]
        longitude <- map[gps_longitude]
        
    }
}
