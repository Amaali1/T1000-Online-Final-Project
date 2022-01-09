//
//  Post.swift
//  finalproject7
//
//  Created by Amaal  on 28/12/2021.
//

import Foundation
import UIKit

struct Post: Decodable {
    var id: String
    var image: String
    var likes: Int
    var text: String
    var owner: User
    var tags: [String]?
}
