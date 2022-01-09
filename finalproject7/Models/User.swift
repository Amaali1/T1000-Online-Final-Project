//
//  User.swift
//  finalproject7
//
//  Created by Amaal  on 01/01/2022.
//

import Foundation
import UIKit

struct User: Decodable
{
    var id: String
    var firstName: String
    var lastName: String
    var picture: String?
    var phone: String?
    var email: String?
    var gender: String?
    var location: location?
}
