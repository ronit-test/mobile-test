//
//  ResourceDetailProtocols.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import UIKit
import MessageUI
import CoreLocation

protocol ResourceDetailViewProtocol: class {
    var presenter: ResourceDetailPresenterProtocol? { get set }
    
    
    func showResourceDetail(forResource resource: ResourceModel)
    func showEmailScreen(emailAddress : String)
    func showResourceImage(image : UIImage)
    func showWebsite(websiteUrl: String)
    func sendAlertErrorWithMessage(alertMessage : String)
}

protocol ResourceDetailRouterProtocol: class {
    static func createResourceDetailModule(forResource resource: ResourceModel) -> UIViewController
}

protocol ResourceDetailPresenterProtocol: class {
    var view: ResourceDetailViewProtocol? { get set }
    var router: ResourceDetailRouterProtocol? { get set }
    var resource: ResourceModel? { get set }
    var interactor: ResourceDetailPresenterToResourceDetailInteractorProtocol? {get set}
    
    func viewDidLoad()
    func startFetchingImage(resourceUrl : String)
    func goToURL(resourceUrl : String)
    func goToMaps(coordinate : CLLocationCoordinate2D)
    func goToWebsite(websiteUrl : String)
    func callNumber(phoneNumber : String)
    func sendEmail(emailAddress : String)
}

protocol ResourceDetailPresenterToResourceDetailInteractorProtocol: class {
    var presenter:ResourceDetailInteractorToResourceDetailPresenterProtocol? {get set}
    func fetchImageForResource(resourceImageUrl : String)
}

protocol ResourceDetailInteractorToResourceDetailPresenterProtocol: class {
    func fetchedSuccess(image : UIImage)
}
