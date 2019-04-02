//
//  ResourceDetailViewController.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import UIKit
import CoreLocation
import MessageUI

class ResourceDetailViewController: UIViewController,UIWebViewDelegate,MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var resourceTableView: UITableView!
    var presenter: ResourceDetailPresenterProtocol?
    var resource: ResourceModel?
    var contactInfoArrayList: [(String,String)] = []
    var socialMediaArrayList: [(String,String)] = []
    var businesHoursArrayList: [(String,String)] = []
    var webV:UIWebView = UIWebView()
    var back: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Resource"
        presenter?.viewDidLoad()
        
    }
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    @objc func goToSocialMediaURL(_ sender: Any) {
        presenter?.goToWebsite(websiteUrl: socialMediaArrayList[(sender as AnyObject).tag].1)
        
    }
    
    @objc func goback(_ sender: Any) {
        self.webV.removeFromSuperview()
        self.back.removeFromSuperview()
    }
    
    @objc func cellAction(_ sender: Any) {
        
        if let cell = (sender as AnyObject).superview??.superview as? ResourceContactInfoCell {
            
            let indexPath: IndexPath = self.resourceTableView.indexPath(for: cell)!
            
            if self.contactInfoArrayList[indexPath.row].0.contains("NUMBER") {
                
                let phone = self.contactInfoArrayList[indexPath.row].1
                presenter?.callNumber(phoneNumber : phone)
                
            }
                
            else if self.contactInfoArrayList[indexPath.row].0.contains("EMAIL") {
                presenter?.sendEmail(emailAddress: self.contactInfoArrayList[indexPath.row].1)
                
                
            }
                
            else if self.contactInfoArrayList[indexPath.row].0.contains("WEBSITE") {
                presenter?.goToWebsite(websiteUrl: self.contactInfoArrayList[indexPath.row].1)
                
                
                
            }
            
            
            
        }
        
        if let cell = (sender as AnyObject).superview??.superview as? ResourceAddressCell {
            
            let indexPath: IndexPath = self.resourceTableView.indexPath(for: cell)!
            
            var coordinate = CLLocationCoordinate2D()
            
            if self.resource?.addresses![indexPath.row].gps != nil {
                coordinate = CLLocationCoordinate2D(latitude: Double((self.resource?.addresses![indexPath.row].gps!.latitude)!) as! CLLocationDegrees,longitude: Double((self.resource?.addresses![indexPath.row].gps!.longitude)!) as! CLLocationDegrees)
                presenter?.goToMaps(coordinate: coordinate)
            }
            else {
                sendAlertErrorWithMessage(alertMessage: "Invalid GPS data")
            }
            
            
        }
        
    }
    
}


extension ResourceDetailViewController: ResourceDetailViewProtocol {
    func sendAlertErrorWithMessage(alertMessage: String) {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showResourceDetail(forResource resource: ResourceModel) {
        self.resource = resource
        self.titleLabel.text = resource.title!
        self.descriptionTextView.text = resource.description!.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
        presenter?.startFetchingImage(resourceUrl: resource.photo!)
        self.resourceTableView.reloadData()
        
    }
    
    func showEmailScreen(emailAddress : String) {
        if MFMailComposeViewController.canSendMail()
        {
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self as MFMailComposeViewControllerDelegate // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
            mailComposerVC.setSubject("Send Email")
            mailComposerVC.setMessageBody("Send Email", isHTML: false)
            mailComposerVC.setToRecipients(["\(emailAddress)"])
            self.present(mailComposerVC, animated: true, completion: nil)
            
        }
    }
    
    func showWebsite(websiteUrl: String) {
        webV = UIWebView(frame: CGRect(x: UIScreen.main.bounds.width/4, y: UIScreen.main.bounds.height/4, width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/2))
        webV.loadRequest(NSURLRequest(url: NSURL(string: websiteUrl)! as URL) as URLRequest)
        webV.delegate = self;
        back = UIButton(frame: CGRect(x: webV.frame.origin.x, y: webV.frame.origin.y - 30, width: 70, height: 30))
        back.setTitle("Dismiss", for: .normal)
        back.setTitleColor(.green, for: .normal)
        back.addTarget(self, action: #selector(ResourceDetailViewController.goback(_:)), for: .touchUpInside)
        self.view.addSubview(webV)
        self.view.addSubview(back)
        
    }
    
    func showResourceImage(image : UIImage) {
        self.photoImageView.image = image
    }
    
    
    
    
    
    
    
}


extension ResourceDetailViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        
        switch (section) {
            
        case 0:
            
            contactInfoArrayList = []
            
            if self.resource?.contactInfo?.email != nil
            {
                
                count = count + 1
                contactInfoArrayList.append(("EMAIL ADDRESS", (self.resource?.contactInfo?.email![0])!))
            }
            if self.resource?.contactInfo?.faxNumber != nil
            {
                
                count = count + 1
                contactInfoArrayList.append(("FAX NUMBER", (self.resource?.contactInfo?.faxNumber![0])!))
            }
            if self.resource?.contactInfo?.tollFree != nil
            {
                count = count + 1
                contactInfoArrayList.append(("TOLL-FREE NUMBER", (self.resource?.contactInfo?.tollFree![0])!))
            }
            if self.resource?.contactInfo?.phoneNumber != nil
            {
                count = count + 1
                contactInfoArrayList.append(("PHONE NUMBER", (self.resource?.contactInfo?.phoneNumber![0])!))
            }
            if self.resource?.contactInfo?.website != nil
            {
                count = count + 1
                contactInfoArrayList.append(("WEBSITE", (self.resource?.contactInfo?.website![0])!))
            }
        case 1:
            if self.resource?.addresses != nil
            {
                count = (self.resource?.addresses?.count)!
            }
            
        case 2:
            if self.resource?.socialMedia != nil
            {
                count = 1
                
                socialMediaArrayList.append(("facebook",(self.resource?.socialMedia?.facebook![0])!))
                socialMediaArrayList.append(("twitter",(self.resource?.socialMedia?.twitter![0])!))
                
                socialMediaArrayList.append(("youtube",(self.resource?.socialMedia?.youtubeChannel![0])!))
            }
            
            
        case 3:
            businesHoursArrayList = []
            if self.resource?.bizHours?.sunday != nil
            {
                count = count + 1
                let fromTo = (self.resource?.bizHours?.sunday?.from!)!+" - "+(self.resource?.bizHours?.sunday?.to!)!
                businesHoursArrayList.append(("Sunday",fromTo))
            }
            if self.resource?.bizHours?.monday != nil
            {
                count = count + 1
                let fromTo = (self.resource?.bizHours?.monday?.from!)!+" - "+(self.resource?.bizHours?.monday?.to!)!
                businesHoursArrayList.append(("Monday",fromTo))
            }
        default:
            count = 0
        }
        print(section)
        print(count)
        
        return count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch (indexPath.section) {
        case 0:
            
            let cell : ResourceContactInfoCell = tableView.dequeueReusableCell(withIdentifier: "resourceContactInfoCell", for: indexPath) as! ResourceContactInfoCell
            cell.titleLabel.text = contactInfoArrayList[indexPath.row].0
            cell.subtitleLabel.text = contactInfoArrayList[indexPath.row].1
            cell.callButton.addTarget(self, action: #selector(ResourceDetailViewController.cellAction(_:)), for: .touchUpInside)
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resourceAddressCell") as! ResourceAddressCell
            print(indexPath.row)
            cell.subtitleTextView.text = "\(resource?.addresses?[indexPath.row].label ?? "") \(resource?.addresses?[indexPath.row].address1 ?? "") \(resource?.addresses?[indexPath.row].city ?? "") \(resource?.addresses?[indexPath.row].zipCode ?? "") \(resource?.addresses?[indexPath.row].state ?? "") \(resource?.addresses?[indexPath.row].country ?? "")"
            cell.goToLocationButton.addTarget(self, action: #selector(ResourceDetailViewController.cellAction(_:)), for: .touchUpInside)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resourceSocialMediaCell") as! ResourceSocialMediaCell
            
            cell.facebookButton.addTarget(self, action: #selector(ResourceDetailViewController.goToSocialMediaURL(_:)), for: .touchUpInside)
            cell.twitterButton.addTarget(self, action: #selector(ResourceDetailViewController.goToSocialMediaURL(_:)), for: .touchUpInside)
            cell.youtubeButton.addTarget(self, action: #selector(ResourceDetailViewController.goToSocialMediaURL(_:)), for: .touchUpInside)
            
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resourceBusinessHoursCell") as! ResourceBusinessHoursCell
            cell.titleLabel.text = businesHoursArrayList[indexPath.row].0
            cell.subtitleLabel.text = businesHoursArrayList[indexPath.row].1
            return cell
            
        default:
            let cell = UITableViewCell()
            return cell
        }
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String?
    {
        var titleForHeader = ""
        
        switch (section) {
            
        case 0:
            
            titleForHeader = "CONTACT INFORMATION"
            

        case 1:
            
            titleForHeader = "ADDRESS"
        
        case 2:
            
            titleForHeader = "NOTES"
        
        case 3:
            
            titleForHeader = "BUSINESS HOURS"
        
        default:
            titleForHeader = ""
        }
        return titleForHeader
        
    }
    
    
    
}

class ResourceContactInfoCell:UITableViewCell{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    
}

class ResourceAddressCell:UITableViewCell{
    
    @IBOutlet weak var subtitleTextView: UITextView!
    @IBOutlet weak var goToLocationButton: UIButton!
    
}

class ResourceSocialMediaCell:UITableViewCell{
    
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var youtubeButton: UIButton!
    
}

class ResourceBusinessHoursCell:UITableViewCell{
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
}
