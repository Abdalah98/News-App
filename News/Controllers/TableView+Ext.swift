//
//  TableView+Ext.swift
//  News
//
//  Created by Abdallah on 8/13/21.
//

import UIKit
extension SearchVC : UITableViewDelegate , UITableViewDataSource{
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.favoritesCell, for: indexPath) as! FavoritesCell
        let article = articles[indexPath.row]
        cell.set(articles: article)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Details", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsHeadlineVC
        nextViewController.articles = articles[indexPath.item]
        nextViewController.modalPresentationStyle = .automatic
        self.show(nextViewController, sender: self)
    }
}
