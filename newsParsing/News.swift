//
//  File.swift
//  newsParsing
//
//  Created by Ivan Adoniev on 14.01.2022.
//

import Foundation
struct Response: Decodable {
    let news: [News]
}
    
struct News: Decodable {
    var title: String?
    var description: String?
    var image: String?
    var url: String?
    var author: String?
}

