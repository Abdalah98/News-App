//
//  SearchBar+Ext.swift
//  News
//
//  Created by Abdallah on 8/13/21.
//

import UIKit
extension SearchVC:UISearchBarDelegate,UISearchControllerDelegate{
    
    func search(){
        let search   = UISearchController()
        search.searchBar.delegate = self
        search.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = search
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        NetworkManger.shared.searchAllEverything(searchText: searchText) {[weak self] (result) in
            guard let self = self else{return}
            
            self.dismissLoadingView()
            switch result {
            case .success(let response):
                
                self.articles = response.articles ?? []
                self.dismissLoadingView()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.dismissLoadingView()
                self.showAlert(withTitle: "Some thing error", withMessage: error.rawValue)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        articles.removeAll()
        tableView.reloadData()
    }
    
}
