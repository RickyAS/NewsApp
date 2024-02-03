//
//  SourceCell.swift
//  NewsApp
//
//  Created by amartek on 03/02/24.
//

import UIKit

class SourceCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(source: SourceEntity) {
        lblTitle.text = "\(source.name) \(source.flag)"
        lblDesc.text = source.description
    }
    
}
