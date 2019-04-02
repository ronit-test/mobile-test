//
//  CategoryRouter.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation
import UIKit

class CategoryRouter:PresenterToRouterProtocol{
    
    static func createModule() -> CategoryViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = CategoryPresenter()
        let interactor: PresenterToInteractorProtocol = CategoryInteractor()
        let router:PresenterToRouterProtocol = CategoryRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToResourceScreen(navigationConroller navigationController:UINavigationController, forCategory category : CategoryModel) {
        
        let resourceModule = ResourceRouter.createResourceModule(forCategory: category)
        navigationController.pushViewController(resourceModule,animated: true)
        
    }
    
}
