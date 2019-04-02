//
//  ResourcePresenter.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation

class ResourcePresenter:ViewToPresenterResourceProtocol{
    
    var view: PresenterToViewResourceProtocol?
    
    var interactor: PresenterToInteractorResourceProtocol?
    
    var router: PresenterToRouterResourceProtocol?
    var category: CategoryModel?
    
    func startFetchingResource() {
        interactor?.fetchResource(category : category!)
    }
    
    func resourceFetchAlphabeticallyAscending(resourceList: Array<ResourceModel>)
    {
        var alphabeticallyAscendingResourceList = resourceList
        
        alphabeticallyAscendingResourceList = alphabeticallyAscendingResourceList.sorted(by: { (item1, item2) -> Bool in
            return item1.title!.compare(item2.title!) == ComparisonResult.orderedAscending
        })
        view?.onResourceResponseSuccess(resourceModelArrayList: alphabeticallyAscendingResourceList)
    }
    
    func resourceFetchAlphabeticallyDescending(resourceList: Array<ResourceModel>)
    {
        var alphabeticallyAscendingResourceList = resourceList
        
        alphabeticallyAscendingResourceList = alphabeticallyAscendingResourceList.sorted(by: { (item1, item2) -> Bool in
            return item1.title!.compare(item2.title!) == ComparisonResult.orderedDescending
        })
        view?.onResourceResponseSuccess(resourceModelArrayList: alphabeticallyAscendingResourceList)
        
    }
    
    func showResourceDetail(forResource resource:ResourceModel) {
        router?.presentResourceDetailScreen(from: view!, forResource: resource)
    }
    
    
}

extension ResourcePresenter:InteractorToPresenterResourceProtocol{
    
    func resourceFetchSuccess(resourceList: Array<ResourceModel>) {
        view?.onResourceResponseSuccess(resourceModelArrayList: resourceList)
    }
    
    func resourceFetchFailed() {
        view?.onResourceResponseFailed(error: "Some Error message from api response")
    }
    
    
}
