//
//  headlineVC.swift
//  News
//
//  Created by Abdallah on 8/8/21.
//

import UIKit
import SafariServices

class headlineVC: UIViewController {
    
    @IBOutlet weak var topHeadlineCountryCollectionView: UICollectionView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var articles = [Article](){
        didSet{
            DispatchQueue.main.async {
                self.pageController.numberOfPages = self.articles.count
                self.topHeadlineCountryCollectionView.reloadData()
            }
        }
    }
    
    var sources  = [SourceData]()
    var timer = Timer()
    var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollection()
        configuretopHeadlineCountryCollectionView()
        startTimer()
    }
    
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
    
    
    func fetchData(){
        NetworkManger.shared.getTopHeadlinesCountry { [weak self] result in
            guard let self = self else{return}
            
            self.dismissLoadingView()
            switch result {
            case .success(let response):

                self.articles = response.articles ?? []
                self.dismissLoadingView()
                DispatchQueue.main.async {
                    self.topHeadlineCountryCollectionView.reloadData()
                }
            case .failure(let error):
                self.dismissLoadingView()

                self.showAlert(withTitle: "Some thing error", withMessage: error.rawValue)
            }
        }
        
        
        NetworkManger.shared.getTopHeadlinesSources { [weak self] result in
            guard let self = self else{return}
            self.dismissLoadingView()

            switch result {
            case .success(let response):
                
                self.sources = response.sources ?? []
                self.dismissLoadingView()
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                self.dismissLoadingView()
                self.showAlert(withTitle: "Some thing error", withMessage: error.rawValue)
            }
        }
    }
    
    
    fileprivate func configuretopHeadlineCountryCollectionView(){
        let nib = UINib(nibName: Constant.topCountryCell, bundle: nil)
        topHeadlineCountryCollectionView.register(nib, forCellWithReuseIdentifier: Constant.topCountryCell)
    }
    
    
    fileprivate func configureCollection(){
        let nib = UINib(nibName: Constant.sourcesCell, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: Constant.sourcesCell)
    }
    
    
    func startTimer(){
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    
    
    @objc func changeImage() {
        if articles.count > 1 {
            if counter < articles.count - 1{
                counter += 1
            }else{
                counter = 0
            }
            let index = IndexPath.init(item: counter  , section: 0)
            self.topHeadlineCountryCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageController.currentPage = counter
        }
    }
    
}


extension headlineVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topHeadlineCountryCollectionView{
            return articles.count
        }
        return sources.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topHeadlineCountryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.topCountryCell, for: indexPath) as! TopCountryCell
            let articlesData = articles[indexPath.item]
            cell.image.image = UIImage(named: "newspaper")
            cell.set(articles: articlesData)
            
            return cell
            
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.sourcesCell, for: indexPath) as! sourcesCell
        let sourcesData = sources[indexPath.item]
        cell.set(data: sourcesData)
        cell.callBack = {
            
            self.goSafari(urlString: sourcesData.url ?? "")
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topHeadlineCountryCollectionView {
            return CGSize(width: collectionView.frame.width, height: 200)
        }
        return CGSize(width: collectionView.frame.width - 20, height: 270)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == topHeadlineCountryCollectionView {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right:0)
            
        }
        return UIEdgeInsets(top: 20, left: 10, bottom: 10, right:10)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == topHeadlineCountryCollectionView {
            return 0
        }
        return 10
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == topHeadlineCountryCollectionView{
            pageController.currentPage = indexPath.item
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Details", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailsVC") as! DetailsHeadlineVC
        nextViewController.articles = articles[indexPath.item]
        nextViewController.modalPresentationStyle = .automatic
        self.show(nextViewController, sender: self)
    }
    
}


