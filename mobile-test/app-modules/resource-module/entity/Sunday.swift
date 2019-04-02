//
//  Sunday.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation
import ObjectMapper

private let sunday_from = "from"
private let sunday_to = "to"


class Sunday: Mappable{
    
    internal var from:String?
    internal var to:String?
    
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        from <- map[sunday_from]
        to <- map[sunday_to]
    }
}
