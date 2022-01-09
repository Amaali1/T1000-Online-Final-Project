//
//  Comment.swift
//  finalproject7
//
//  Created by Amaal  on 03/01/2022.
//

import Foundation
struct Comment: Decodable {
    var id: String
    var message: String
    var owner: User
}
