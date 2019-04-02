//
//  Monday.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation
import ObjectMapper

private let monday_from = "from"
private let monday_to = "to"


class Monday: Mappable{
    
    internal var from:String?
    internal var to:String?
    
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        from <- map[monday_from]
        to <- map[monday_to]
    }
}

