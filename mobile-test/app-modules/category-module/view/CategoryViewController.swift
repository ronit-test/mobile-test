//
//  CategoryViewController.swift
//  mobile-test
//
//  Created by Ronit on 2019-04-01.
//  Copyright © 2019 Ronit. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var presentor:ViewToPresenterProtocol?
    
    @IBOutlet weak var uiTableView: UITableView!
    var categoryArrayList:Array<CategoryModel> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Category-Module"
        presentor?.startFetchingCategory()
        showProgressIndicator(view: self.view)
        
        uiTableView.delegate = self
        uiTableView.dataSource = self
        
    }
}

extension CategoryViewController:PresenterToViewProtocol{
    
    func showCategory(categoryArray: Array<CategoryModel>) {
        
        self.categoryArrayList = categoryArray
        self.uiTableView.reloadData()
        hideProgressIndicator(view: self.view)
        
    }
    
    func showError() {
        
        hideProgressIndicator(view: self.view)
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Category", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}

extension CategoryViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryCell
        cell.title.text = categoryArrayList[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        presentor?.showResourceController(navigationController: navigationController!, forCategory: self.categoryArrayList[indexPath.row])
        
    }
    
    
}

class CategoryCell:UITableViewCell{
    
    @IBOutlet weak var title: UILabel!
    
}
