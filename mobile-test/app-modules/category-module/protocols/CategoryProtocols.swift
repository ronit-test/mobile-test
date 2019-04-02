//
//  CategoryProtocols.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: class{
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingCategory()
    func showResourceController(navigationController:UINavigationController, forCategory category : CategoryModel)
    
}

protocol PresenterToViewProtocol: class{
    func showCategory(categoryArray:Array<CategoryModel>)
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> CategoryViewController
    func pushToResourceScreen(navigationConroller:UINavigationController, forCategory category : CategoryModel)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchCategory()
}

protocol InteractorToPresenterProtocol: class {
    func categoryFetchedSuccess(categoryModelArray:Array<CategoryModel>)
    func categoryFetchFailed()
}
