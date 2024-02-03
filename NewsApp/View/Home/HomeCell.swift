//
//  HomeCell.swift
//  NewsApp
//
//  Created by amartek on 02/02/24.
//

import UIKit

class HomeCell: UICollectionViewCell {
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgIcon.superview?.layer.cornerRadius = 12
    }
    
    func setup(category: NewsCategories) {
        imgIcon.image = UIImage(systemName: category.icon)
        lblTitle.text = category.rawValue.capitalized
        imgIcon.superview?.backgroundColor = category.backColor
    }

}
