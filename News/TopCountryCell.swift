//
//  TopCountryCell.swift
//  News
//
//  Created by Abdallah on 8/10/21.
//

import UIKit
import SDWebImage
class TopCountryCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!

    func set (articles: Article){
        date.text = articles.publishedAt?.convertToDisplayFormat()
        title.text = articles.title
        image.sd_setImage(with:URL(string: articles.urlToImage ?? ""))
    }
}
