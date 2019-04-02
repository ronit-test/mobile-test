//
//  ResourceRouter.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import Foundation
import UIKit

class ResourceRouter:PresenterToRouterResourceProtocol{
    
    static func createResourceModule(forCategory category: CategoryModel) -> ResourceViewController {
        
        let view = ResourceRouter.mainstoryboard.instantiateViewController(withIdentifier: "ResourceViewController") as! ResourceViewController
        
        let presenter: ViewToPresenterResourceProtocol & InteractorToPresenterResourceProtocol = ResourcePresenter()
        let interactor: PresenterToInteractorResourceProtocol = ResourceInteractor()
        let router:PresenterToRouterResourceProtocol = ResourceRouter()
        
        view.resourcePresenter = presenter
        presenter.view = view
        presenter.category = category
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func presentResourceDetailScreen(from view: PresenterToViewResourceProtocol, forResource resource: ResourceModel) {
        let postDetailViewController = ResourceDetailRouter.createResourceDetailModule(forResource: resource)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(postDetailViewController, animated: true)
        }
    }
    
}
