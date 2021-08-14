//
//  sourcesCell.swift
//  News
//
//  Created by Abdallah on 8/9/21.
//

import UIKit

class sourcesCell: UICollectionViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var langLabel: UILabel!
    
    var callBack: (() ->())?
 
    func set (data :SourceData){
        descriptionLabel.text = data.sourceDescription
        name.text = data.name
        countryLabel.text = data.country
        langLabel.text = data.language

    }
    
    @IBAction func readMoreAction(_ sender: Any) {
        callBack?()
    }
}
