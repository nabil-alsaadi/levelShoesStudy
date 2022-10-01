//
//  ItemsResponse.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 01/10/2022.
//

import Foundation
struct ItemsReponse: Codable, Hashable {
    var title: String
    var currency: String
    var items: [Item]
}
