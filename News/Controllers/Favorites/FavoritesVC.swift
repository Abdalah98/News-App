//
//  FavoritesVC.swift
//  News
//
//  Created by Abdallah on 8/11/21.
//

import UIKit
import UserNotifications

class FavoritesVC: UITableViewController {
    
    var articles = [Article]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDesign()
        configureNIBCell()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        featchPersistenceData()
        prepareNotification()

        UIApplication.mainTabaBarController()?.viewControllers?[2].tabBarItem.badgeValue = nil
    }
    
    
    func configureNIBCell(){
        let nib = UINib(nibName: Constant.favoritesCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Constant.favoritesCell)
    }
    
    
    fileprivate func tableViewDesign() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    
    func featchPersistenceData(){
        PersistenceManger.retrieveFavorites { [weak self]result in
            guard let self = self else{return}
            switch result{
            case .success(let favoites):
                if favoites.isEmpty {
                    self.showAlert(withTitle: "", withMessage: "No Favorite?\nAdd one on the News screen " )
                }
                else{
                    self.articles = favoites
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                self.showAlert(withTitle: "Some thing worng!", withMessage: error.rawValue)
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.favoritesCell, for: indexPath) as! FavoritesCell
        let article = articles[indexPath.row]
        cell.set(articles: article)
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else{return}
        PersistenceManger.updateWith(favorite: articles[indexPath.row], actionType: .remove) {[weak self] error in
            guard let self = self else{return}
            guard let error = error else{
                self.articles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            self.showAlert(withTitle: "Unable to remove", withMessage: error.rawValue)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Details", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsHeadlineVC
        nextViewController.articles = articles[indexPath.item]
        nextViewController.modalPresentationStyle = .automatic
        self.show(nextViewController, sender: self)
    }
    func prepareNotification() {
        // Make sure the restaurant array is not empty
        if articles.count <= 0 {
            return
        }

        // Pick a restaurant randomly
        let randomNum = Int.random(in: 0..<articles.count)
        let suggestedArticle = articles[randomNum]

        // Create the user notification
        let content = UNMutableNotificationContent()
        content.title = "News Recommendation \(suggestedArticle.title!)"
        content.body = "I recommend you to Read \(suggestedArticle.articleDescription!)."
        content.sound = UNNotificationSound.default
 
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "news.suggestedArticle", content: content, trigger: trigger)

        // Schedule the notification
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

    }
}

