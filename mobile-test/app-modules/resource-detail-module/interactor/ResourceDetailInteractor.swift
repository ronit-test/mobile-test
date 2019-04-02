//
//  ResourceDetailInteractor.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class ResourceDetailInteractor: ResourceDetailPresenterToResourceDetailInteractorProtocol{
    var presenter: ResourceDetailInteractorToResourceDetailPresenterProtocol?
    
    func fetchImageForResource(resourceImageUrl : String){
        
        var image = UIImage()
        Alamofire.request(resourceImageUrl).responseData { (response) in
            if response.error == nil {
                print(response.result)
                if let data = response.data {
                    image = UIImage(data: data)!
                    self.presenter?.fetchedSuccess(image: image)
                }
            }
        }
        
    }
    
    
    
    
}
