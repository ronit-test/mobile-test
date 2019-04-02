//
//  ResourceDetailPresenter.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import UIKit
import MessageUI
import CoreLocation
import MapKit

class ResourceDetailPresenter: ResourceDetailPresenterProtocol {
    func goToMaps(coordinate: CLLocationCoordinate2D) {
        
        
        let placeMark: MKPlacemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
            let destination: MKMapItem = MKMapItem(placemark: placeMark)
            let launchOptions: [String : AnyObject] = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving as AnyObject]
            destination.openInMaps(launchOptions: launchOptions)
        
    }
    
    func callNumber(phoneNumber : String) {
        
        if (phoneNumber != "") {
            if let url = URL(string: "tel://\(phoneNumber))"), !url.absoluteString.isEmpty {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        else {
            sendAlertErrorWithMessage(alertMessage: "Phone number is empty")
            
        }
        
    }
    
    func sendEmail(emailAddress : String) {
        
        if (emailAddress != "") {
            view?.showEmailScreen(emailAddress: emailAddress)
        }
        else {
            sendAlertErrorWithMessage(alertMessage: "Email is empty")
            
        }
        
    }
    
    func sendAlertErrorWithMessage(alertMessage: String) {
        view?.sendAlertErrorWithMessage(alertMessage: alertMessage)
    }
    
    func goToWebsite(websiteUrl : String){
        if websiteUrl != "" {
            view?.showWebsite(websiteUrl: websiteUrl)
        }
        else{
            sendAlertErrorWithMessage(alertMessage: "URL is empty")
            
        }
    }
    
    
    
    
    weak var view: ResourceDetailViewProtocol?
    var router: ResourceDetailRouterProtocol?
    var resource: ResourceModel?
    var interactor: ResourceDetailPresenterToResourceDetailInteractorProtocol?
    func viewDidLoad() {
        view?.showResourceDetail(forResource: resource!)
    }
    
    func startFetchingImage(resourceUrl : String){
        interactor?.fetchImageForResource(resourceImageUrl: resourceUrl)
        
    }
    
    func goToURL(resourceUrl: String) {
        view?.showResourceDetail(forResource: resource!)
    }
    
}

extension ResourceDetailPresenter: ResourceDetailInteractorToResourceDetailPresenterProtocol{
    func fetchedSuccess(image: UIImage) {
        view?.showResourceImage(image: image)
    }
    
    
}
