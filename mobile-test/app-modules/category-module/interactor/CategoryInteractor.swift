//
//  CategoryInteractor.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class CategoryInteractor: PresenterToInteractorProtocol{
    var presenter: InteractorToPresenterProtocol?
    
    func fetchCategory() {
        Alamofire.request(API_CATEGORIES_LIST).responseJSON { response in
            
            if(response.response?.statusCode == 200){
                if let json = response.result.value as AnyObject? {
                    let arrayObject = Mapper<CategoryModel>().mapArray(JSONArray: json as! [[String : Any]]);
                    self.presenter?.categoryFetchedSuccess(categoryModelArray: arrayObject)
                }
            }else {
                self.presenter?.categoryFetchFailed()
            }
        }
    }
    
    
    
    
}
