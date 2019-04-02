//
//  ResourceProtocols.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation

protocol ViewToPresenterResourceProtocol:class{
    
    
    var view: PresenterToViewResourceProtocol? {get set}
    var interactor: PresenterToInteractorResourceProtocol? {get set}
    var router: PresenterToRouterResourceProtocol? {get set}
    func startFetchingResource()
    func resourceFetchAlphabeticallyAscending(resourceList: Array<ResourceModel>)
    func resourceFetchAlphabeticallyDescending(resourceList: Array<ResourceModel>)
    func showResourceDetail(forResource resource: ResourceModel)
    var category: CategoryModel? { get set }
    
}

protocol PresenterToViewResourceProtocol:class {
    
    func onResourceResponseSuccess(resourceModelArrayList:Array<ResourceModel>)
    func onResourceResponseFailed(error:String)
    
}

protocol PresenterToRouterResourceProtocol:class {
    
    static func createResourceModule(forCategory category: CategoryModel) -> ResourceViewController
    
    func presentResourceDetailScreen(from view: PresenterToViewResourceProtocol, forResource resource: ResourceModel)
    
}

protocol PresenterToInteractorResourceProtocol:class {
    
    var presenter:InteractorToPresenterResourceProtocol? {get set}
    func fetchResource(category : CategoryModel)
    
}

protocol InteractorToPresenterResourceProtocol:class {
    
    func resourceFetchSuccess(resourceList:Array<ResourceModel>)
    func resourceFetchFailed()
    
}
