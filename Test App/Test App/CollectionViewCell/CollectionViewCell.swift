//
//  CollectionViewCell.swift
//  Test App
//
//  Created by Владимир on 21.01.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var labelView: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
       setShadow()
    }
    
    private func setShadow() {
        contentView.layer.cornerRadius = 6
        contentView.layer.borderWidth = 2
        contentView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 0.7
    }
    
}


