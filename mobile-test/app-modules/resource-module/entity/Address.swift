//
//  Address.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation
import ObjectMapper

private let address_label = "label"
private let address_address1 = "address1"
private let address_city = "city"
private let address_zipCode = "zipCode"
private let address_state = "state"
private let address_country = "country"
private let address_gps = "gps"


class Address: Mappable{
    
    internal var label:String?
    internal var address1:String?
    internal var city:String?
    internal var zipCode:String?
    internal var state:String?
    internal var country:String?
    internal var gps:GPS?
    
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        label <- map[address_label]
        address1 <- map[address_address1]
        city <- map[address_city]
        zipCode <- map[address_zipCode]
        state <- map[address_state]
        country <- map[address_country]
        gps <- map[address_gps]
        
    }
}
