//
//  ResourceViewController.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ResourceViewController: UIViewController {
    
    var resourcePresenter:ViewToPresenterResourceProtocol?
    
    @IBOutlet weak var myTableView: UITableView!
    var arrayList:Array<ResourceModel> = Array()
    var clicked = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Resource-Module"
        resourcePresenter?.startFetchingResource()
        
        
        showProgressIndicator(view: self.view)
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        clicked.toggle()
        if (clicked) {
            resourcePresenter?.resourceFetchAlphabeticallyAscending(resourceList: self.arrayList)
        }
        else {
            resourcePresenter?.resourceFetchAlphabeticallyDescending(resourceList: self.arrayList)
        }
        
    }
    
}

extension ResourceViewController:PresenterToViewResourceProtocol{
    
    func onResourceResponseSuccess(resourceModelArrayList: Array<ResourceModel>) {
        
        self.arrayList = resourceModelArrayList
        
        self.myTableView.reloadData()
        hideProgressIndicator(view: self.view)
        
    }
    
    func onResourceResponseFailed(error: String) {
        
        hideProgressIndicator(view: self.view)
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Category", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}

extension ResourceViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResourceCell
        cell.mTitle.text = arrayList[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let header = UIButton(frame:  CGRect(x: 0,y: 0,width: view.frame.width,height: 30))
        header.backgroundColor = UIColor.red
        header.setTitle("Sort", for: .normal)
        header.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return header
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        resourcePresenter?.showResourceDetail(forResource: arrayList[indexPath.row])
        
    }
    
    
}

class ResourceCell:UITableViewCell{
    
    @IBOutlet weak var mTitle: UILabel!
    
}
