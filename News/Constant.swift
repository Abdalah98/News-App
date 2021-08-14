//
//  Constant.swift
//  GitHub
//
//  Created by Abdalah Omar on 10/19/20.
//  Copyright © 2020 Abdallah. All rights reserved.
//

import UIKit

enum URLS {
    static let apiKey                = ""
    // when you get apikey and add that remove line 14 to succsebulid
    #error("Pleas go to NewApi to get apiKey to make reqeust and remove this line ")
    static let main                 = "https://newsapi.org/v2/"
    static let topHeadlinesSources  = main + "top-headlines/sources?apiKey=" + apiKey
    static let topHeadlinesCountry  = main + "top-headlines?country=eg&apiKey=" + apiKey

}

enum Constant {
    static let showDetials = "details"
    static let topCountryCell = "TopCountryCell"
    static let sourcesCell = "sourcesCell"
    static let favoritesCell = "FavoritesCell"

    
    
}

//
//API_KEY
 //https://newsapi.org/v2/top-headlines?country=us&apiKey=API_KEY
 //https://newsapi.org/v2/everything?q=Apple&from=2021-08-04&sortBy=popularity&apiKey=API_KEY




