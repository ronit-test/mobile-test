//
//  CategoryPresenter.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation
import UIKit

class CategoryPresenter:ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetchingCategory() {
        interactor?.fetchCategory()
    }
    
    func showResourceController(navigationController: UINavigationController, forCategory category  : CategoryModel) {
        router?.pushToResourceScreen(navigationConroller: navigationController, forCategory: category)
    }
    
}

extension CategoryPresenter: InteractorToPresenterProtocol{
    
    func categoryFetchedSuccess(categoryModelArray: Array<CategoryModel>) {
        view?.showCategory(categoryArray: categoryModelArray)
    }
    
    func categoryFetchFailed() {
        view?.showError()
    }
    
    
}
