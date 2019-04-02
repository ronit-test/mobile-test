//
//  CategoryModel.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation
import ObjectMapper

private let category_id = "_id"
private let category_updated_at = "updated_at"
private let category_slug = "slug"
private let category_custom_module_eid = "custom_module_eid"
private let category_eid = "eid"
private let category_title = "title"
private let category_description = "description"
private let category_v = "__v"
private let category_active = "_active"
private let category_created_at = "created_at"

class CategoryModel: Mappable{
    
    internal var id:String?
    internal var updated_at:String?
    internal var slug:String?
    internal var custom_module_eid:String?
    internal var eid:String?
    internal var title:String?
    internal var description:String?
    internal var v:Int?
    internal var active:Bool?
    internal var created_at:String?
    
    required init?(map:Map) {
        mapping(map: map)
    }
    
    func mapping(map:Map){
        id <- map[category_id]
        updated_at <- map[category_updated_at]
        slug <- map[category_slug]
        custom_module_eid <- map[category_custom_module_eid]
        eid <- map[category_eid]
        title <- map[category_title]
        description <- map[category_description]
        v <- map[category_v]
        active <- map[category_active]
        created_at <- map[category_created_at]
    }
}
