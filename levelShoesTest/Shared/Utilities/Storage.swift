//
//  Storage.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 01/10/2022.
//

import Foundation
enum DefaultsKes: String {
    case wishlist = "wishlist"
    case bag = "bag"
}
class Storage {
    static var shared = Storage()
    func saveWishlist(items: [Item]) {
        let defaults = UserDefaults.standard
        let ids = getWishlistIds(items: items)
        defaults.set(ids, forKey: DefaultsKes.wishlist.rawValue)
        defaults.synchronize()
    }
    func saveBag(items: [Item]) {
        let defaults = UserDefaults.standard
        let ids = getBagIds(items: items)
        defaults.set(ids, forKey: DefaultsKes.bag.rawValue)
        defaults.synchronize()
    }
    func loadWishlist(items: [Item]) -> [Item] {
        let defaults = UserDefaults.standard
        let ids = defaults.array(forKey: DefaultsKes.wishlist.rawValue) as? [String] ?? []
        var outItems = items
        for i in 0..<items.count {
            let item = items[i]
            if ids.contains(item.id) {
                outItems[i].isFav = true
            }
        }
        return outItems
    }
    func loadBag(items: [Item]) -> [Item] {
        let defaults = UserDefaults.standard
        let ids = defaults.array(forKey: DefaultsKes.bag.rawValue) as? [String] ?? []
        var outItems = items
        for i in 0..<items.count {
            let item = items[i]
            if ids.contains(item.id) {
                outItems[i].isInBag = true
            }
        }
        return outItems
    }
    func getWishlistIds(items: [Item]) -> [String] {
        var ids = [String]()
        for item in items {
            if item.isFav ?? false {
                ids.append(item.id)
            }
        }
        return ids
    }
    func getBagIds(items: [Item]) -> [String] {
        var ids = [String]()
        for item in items {
            if item.isInBag ?? false {
                ids.append(item.id)
            }
        }
        return ids
    }
}
