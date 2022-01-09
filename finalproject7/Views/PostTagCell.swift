//
//  PostTagCell.swift
//  finalproject7
//
//  Created by Amaal  on 09/01/2022.
//

import UIKit

class PostTagCell: UICollectionViewCell {
    
    @IBOutlet weak var tagNameLabel: UILabel!
    
    @IBOutlet weak var backView: UIView!
    {
        didSet{
            backView.layer.cornerRadius = 8
            
        }
    }
}
