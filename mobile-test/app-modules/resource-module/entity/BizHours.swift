//
//  BizHours.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation
import ObjectMapper

private let bizHours_sunday = "sunday"
private let bizHours_monday = "monday"


class BizHours: Mappable{
    
    internal var sunday:Sunday?
    internal var monday:Monday?
    
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        sunday <- map[bizHours_sunday]
        monday <- map[bizHours_monday]
    }
}
