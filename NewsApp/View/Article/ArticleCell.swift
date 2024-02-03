//
//  ArticleCell.swift
//  NewsApp
//
//  Created by amartek on 03/02/24.
//

import UIKit
import SDWebImage

class ArticleCell: UITableViewCell {
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(article: ArticleEntity) {
        imgNews.sd_setImage(with: URL(string: article.urlToImage ?? ""))
        lblTitle.text =  article.title
        lblDate.text = article.publishedDate
    }
    
}
