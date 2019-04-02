//
//  ResourceInteractor.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ResourceInteractor:PresenterToInteractorResourceProtocol{
    
    var presenter: InteractorToPresenterResourceProtocol?
    
    func fetchResource(category : CategoryModel) {
        
        let url = category.slug == "restaurants" ? api_restaurants_list : api_vacation_spots_list
        Alamofire.request(url).responseJSON { response in
            
            if(response.response?.statusCode == 200){
                if let json = response.result.value as AnyObject? {
                    let arrayObject = Mapper<ResourceModel>().mapArray(JSONArray: json as! [[String : Any]]);
                    self.presenter?.resourceFetchSuccess(resourceList: arrayObject)
                }
            }else {
                self.presenter?.resourceFetchFailed()
            }
        }
        
    }
    
    
    
    
}
