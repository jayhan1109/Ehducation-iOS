//
//  Post.swift
//  Ehducation
//
//  Created by Jeongho Han on 2021-06-15.
//

import Foundation

struct Post {
    let userId: String
    let timestamp: TimeInterval
    let grade: String
    let subject: String
    
    var title: String
    var text: String
    var imageRef: String
    var viewCount: Int
    var answerCount: Int
    var imageCount: Int
}
