//
//  ShadowView.swift
//  finalproject7
//
//  Created by Amaal  on 04/01/2022.
//

import UIKit

class ShadowView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupShadow()
    }
    func setupShadow(){
        self.layer.shadowColor = UIColor.blue.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shadowRadius = 10
        self.layer.cornerRadius = 6
    }
}
