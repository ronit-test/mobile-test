//
//  ContactInfo.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation
import ObjectMapper

private let contactInfo_email = "email"
private let contactInfo_faxNumber = "faxNumber"
private let contactInfo_tollFree = "tollFree"
private let contactInfo_phoneNumber = "phoneNumber"
private let contactInfo_website = "website"


class ContactInfo: Mappable{
    
    internal var email:[String]?
    internal var faxNumber:[String]?
    internal var tollFree:[String]?
    internal var phoneNumber:[String]?
    internal var website:[String]?
    
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        email <- map[contactInfo_email]
        faxNumber <- map[contactInfo_faxNumber]
        tollFree <- map[contactInfo_tollFree]
        phoneNumber <- map[contactInfo_phoneNumber]
        website <- map[contactInfo_website]
    }
}
