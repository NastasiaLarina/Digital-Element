//
//  ItemsCodable.swift
//  Digital Element
//
//  Created by Анастасия Ларина on 29.03.2021.
//

import Foundation

struct Item: Decodable{
    var items: [Items]
}

struct Items: Decodable {
    var id: Int?
    var name: String?
    var price: Double?
    var article: Int?
    var image: String?
}
