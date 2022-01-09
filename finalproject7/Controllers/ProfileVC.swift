//
//  ProfileVC.swift
//  finalproject7
//
//  Created by Amaal  on 07/01/2022.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfileVC: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!{
        didSet{
            profileImageView.makeCircularImage()
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var countyLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        UserAPI.getUserData(id: user.id) { userResponse in
            self.user = userResponse
            self.setupUI()
        }
    }
    
    func setupUI(){
       
        nameLabel.text = user.firstName + " " + user.lastName
        emailLabel.text = user.email
        phoneLabel.text = user.phone
        genderLabel.text = user.gender
        
        if let location = user.location{
            countyLabel.text = location.country! + "_" + location.city!
        }
        
        if let image = user.picture {
            profileImageView.setImageFromStringUrl(stringUrl: image)
            
        }
    }
}
