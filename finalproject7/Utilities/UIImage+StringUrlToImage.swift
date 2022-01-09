//
//  UIImage+StringUrlToImage.swift
//  finalproject7
//
//  Created by Amaal  on 04/01/2022.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromStringUrl(stringUrl: String) {
        if let url = URL(string: stringUrl){
            if let imageData = try? Data(contentsOf: url) {
                self.image = UIImage(data: imageData)
            }
        }
    }
    
    func makeCircularImage(){
        self.layer.cornerRadius = self.frame.width / 2
    }
}
