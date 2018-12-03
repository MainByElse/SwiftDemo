//
//  YPScrollMenuColCell.swift
//  SwiftDemo
//
//  Created by Else丶 on 2018/10/2.
//  Copyright © 2018 Else丶. All rights reserved.
//

import UIKit

class YPScrollMenuColCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var iconImgV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.backView.backgroundColor = UIColor.init(red: 242, green: 242, blue: 242, alpha: 1.0)
        self.backView.layer.cornerRadius = 10
        self.backView.clipsToBounds = true
    }

}
