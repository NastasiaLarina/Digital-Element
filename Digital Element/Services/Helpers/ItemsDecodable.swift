//
//  ItemsDecodable.swift
//  Digital Element
//
//  Created by Анастасия Ларина on 28.03.2021.
//

import Foundation

struct Item: Codable {
    let items: [Items]
}

struct Items: Codable {
    let id: Int
    let name: String
    let price: Double
    let article: Int
    let image: String
}
