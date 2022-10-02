//
//  HomeCoordinator.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 30/09/2022.
//

import Foundation
import UIKit
import SwiftUI
import XCoordinator
import Combine
enum HomeRoute: Route {
    case home
    case productDetails(itemIndex: Int)
    case wishlist
    case pop
    case dismiss
}
class Globals: ObservableObject {
    @Published var itemsResponse: ItemsReponse
    init(itemsResponse: ItemsReponse = ItemsReponse(title: "Loading", currency: "AED", items: [])) {
        self.itemsResponse = itemsResponse
    }
    func addToWishList(item: Item) {
        if let index = itemsResponse.items.firstIndex(of: item) {
            itemsResponse.items[index].isFav = true
            Storage.shared.saveWishlist(items: itemsResponse.items)
        }
    }
    func removeFromWishlist(item: Item) {
        if let index = itemsResponse.items.firstIndex(of: item) {
            itemsResponse.items[index].isFav = false
            Storage.shared.saveWishlist(items: itemsResponse.items)
        }
    }
    func addToBag(item: Item) {
        if let index = itemsResponse.items.firstIndex(of: item) {
            itemsResponse.items[index].isInBag = true
            Storage.shared.saveBag(items: itemsResponse.items)
        }
    }
    func wishListCount() -> Int {
        let items = itemsResponse.items.filter { Item in
            return Item.isFav ?? false
        }
        return items.count
    }
}

class HomeCoordinator: NavigationCoordinator<HomeRoute> {
    @ObservedObject var globals = Globals()
    var cancelSet: Set<AnyCancellable> = []
    init() {
        super.init(initialRoute: .home)
        getItems()
    }
    func getItems() {
        ItmesService.shared.getItems()
            .sink { completion in
                switch completion {
                case.failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { itemsResponse in
                var response = itemsResponse
                response.items = Storage.shared.loadWishlist(items: response.items)
                response.items = Storage.shared.loadBag(items: response.items)
                self.globals.itemsResponse = response
                
            }.store(in: &cancelSet)
    }
    func hideNavigation() {
        self.rootViewController.navigationBar.isHidden = true
    }
    func showNavigation() {
        self.rootViewController.navigationBar.isHidden = false
    }
    // MARK: Overrides

    override func prepareTransition(for route: HomeRoute) -> NavigationTransition {
        switch route {
        case .home:
            hideNavigation()
            let vm = HomeViewModel(router: unownedRouter)
            let view = HomeView(viewModel: vm).environmentObject(globals)
            let vc = UIHostingController(rootView: view)
            return .push(vc)
        case .productDetails(let itemIndex):
            let vm = ProductDetailsViewModel(router: unownedRouter, itemIndex: itemIndex)
            let view = ProductDetailsView(viewModel: vm).environmentObject(globals)
            let vc = UIHostingController(rootView: view)
            return .push(vc)
        case .wishlist:
            let wishlistCoordinator = WishlistCoordinator(globals: globals)
            return .presentFullScreen(wishlistCoordinator)
        case .pop:
            return .pop()
        case .dismiss:
            return .dismiss()
        }
    }

}
