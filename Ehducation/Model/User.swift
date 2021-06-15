//
//  User.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-06-15.
//

import Foundation

struct User {
    let id: String
    let email: String
    var exp: Int
    var answered: Int
    var starred: Int
    
    var username: String{
        return email.components(separatedBy: "@")[0]
    }
}
