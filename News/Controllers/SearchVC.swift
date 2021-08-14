//
//  SearchVC.swift
//  News
//
//  Created by Abdallah on 8/12/21.
//

import UIKit

class SearchVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var articles = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDesign()
        configureNIBCell()
        search()
        self.tableView.allowsSelection = true
    }
    
    
    func configureNIBCell(){
        let nib = UINib(nibName: Constant.favoritesCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constant.favoritesCell)
    }
    
    
    fileprivate func tableViewDesign() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    
}






