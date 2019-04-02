//
//  ResourceModel.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation
import ObjectMapper

private let resource_id = "_id"
private let resource_slug = "slug"
private let resource_eid = "eid"
private let resource_photo = "photo"
private let resource_title = "title"
private let resource_description = "description"
private let resource_category_eid = "category_eid"
private let resource_v = "__v"
private let resource_active = "_active"
private let resource_updated_at = "updated_at"
private let resource_created_at = "created_at"
private let resource_contactInfo = "contactInfo"
private let resource_socialMedia = "socialMedia"
private let resource_addresses = "addresses"
private let resource_freeText = "freeText"
private let resource_bizHours = "bizHours"


class ResourceModel:Mappable{
    
    internal var id:String?
    internal var slug:String?
    internal var eid:String?
    internal var photo:String?
    internal var title:String?
    internal var description:String?
    internal var category_eid:String?
    internal var v:Int?
    internal var active:Bool?
    internal var updated_at:String?
    internal var created_at:String?
    internal var freeText:String?
    internal var contactInfo:ContactInfo?
    internal var socialMedia:SocialMedia?
    internal var addresses:[Address]?
    internal var bizHours:BizHours?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        id <- map[resource_id]
        slug <- map[resource_slug]
        eid <- map[resource_eid]
        photo <- map[resource_photo]
        title <- map[resource_title]
        description <- map[resource_description]
        category_eid <- map[resource_category_eid]
        v <- map[resource_v]
        active <- map[resource_active]
        updated_at <- map[resource_updated_at]
        created_at <- map[resource_created_at]
        freeText <- map[resource_freeText]
        contactInfo <- map[resource_contactInfo]
        socialMedia <- map[resource_socialMedia]
        bizHours <- map[resource_bizHours]
        addresses <- map[resource_addresses]
        
    }
    
}
