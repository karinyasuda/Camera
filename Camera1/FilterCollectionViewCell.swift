//
//  FilterCollectionViewCell.swift
//  CellScroll
//
//  Created by Karin on 2016/04/06.
//  Copyright © 2016年 Karin. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {

    @IBOutlet var filterlabel :UILabel!
    @IBOutlet var exampleimage:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Initialization code
//        
//        filterlabel.text = "sepia"
//        exampleimage.image = UIImage(named: "sepia.jpg")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    }
