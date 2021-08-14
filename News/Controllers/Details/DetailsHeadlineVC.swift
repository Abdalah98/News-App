//
//  DetailsHeadlineVC.swift
//  News
//
//  Created by Abdallah on 8/8/21.
//

import UIKit
import SDWebImage

class DetailsHeadlineVC: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var discription: UILabel!
    @IBOutlet weak var publishAt: UILabel!
    
    var  urlString = ""
    var articles:Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupnavigationController()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    
    func setupnavigationController(){
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.hidesBarsOnSwipe = false
        
        // Configure the navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .systemBackground
        
    }
    
    
    func fetchData() {
        name.text = articles?.title
        discription.text = articles?.articleDescription
        titleLabel.text = articles?.title
        publishAt.text = articles?.publishedAt?.convertToDisplayFormat()
        image.sd_setImage(with: URL(string: articles?.urlToImage ?? ""))
        urlString = articles?.url ?? ""
    }
    
    
    fileprivate  func showBadgeHightLightOfDownlaods(){
        UIApplication.mainTabaBarController()?.viewControllers?[2].tabBarItem.badgeValue = "New"
    }
    
    
    @IBAction func readMoreAction(_ sender: Any) {
        goSafari(urlString: urlString)
    }
    
    
    @IBAction func addFavorite(_ sender: Any) {
        saveInPersistenceFavorite()
    }
    
    
    func saveInPersistenceFavorite(){
        let article = Article(source: articles?.source, author: articles?.author, title: articles?.title, articleDescription: articles?.articleDescription, url: articles?.url, urlToImage: articles?.urlToImage, publishedAt: articles?.urlToImage, content: articles?.content)
        PersistenceManger.updateWith(favorite: article, actionType: .add) { [weak self] error in
            guard let self = self else {return}
            guard let error = error else{
                
                self.showAlert(withTitle: "Success!", withMessage: "You have successfully favorite this user 🎉")
                self.showBadgeHightLightOfDownlaods()
                return
            }
            self.showAlert(withTitle: "Some thing worng!", withMessage: error.rawValue)
            
        }
    }
}

