//
//  ResourceDetailRouter.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import UIKit

class ResourceDetailRouter: ResourceDetailRouterProtocol {
    
    class func createResourceDetailModule(forResource resource: ResourceModel) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ResourceDetailViewController")
        if let view = viewController as? ResourceDetailViewController {
            let presenter: ResourceDetailPresenterProtocol & ResourceDetailInteractorToResourceDetailPresenterProtocol = ResourceDetailPresenter()
            let router: ResourceDetailRouterProtocol = ResourceDetailRouter()
            let interactor: ResourceDetailPresenterToResourceDetailInteractorProtocol = ResourceDetailInteractor()
            
            view.presenter = presenter
            presenter.view = view
            presenter.interactor = interactor
            presenter.resource = resource
            presenter.router = router
            interactor.presenter = presenter
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
