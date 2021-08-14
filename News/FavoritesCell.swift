//
//  FavoritesCell.swift
//  News
//
//  Created by Abdallah on 8/11/21.
//

import UIKit
import SDWebImage
class FavoritesCell: UITableViewCell {

    @IBOutlet weak var imageHeadLine: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func layoutSubviews() {
          super.layoutSubviews()
          contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom:5, right: 10))
      }
   
    func set(articles: Article){
        nameLabel.text = articles.title
        dateLabel.text = articles.publishedAt?.convertToDisplayFormat()
        imageHeadLine.sd_setImage(with: URL(string: articles.urlToImage ?? ""))
    }
}
