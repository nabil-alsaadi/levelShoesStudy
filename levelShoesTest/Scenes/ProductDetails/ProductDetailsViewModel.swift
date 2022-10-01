//
//  ProductDetailsViewModel.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 01/10/2022.
//

import Foundation
import XCoordinator
import Combine
class ProductDetailsViewModel: ObservableObject {
    let router: UnownedRouter<HomeRoute>?
    let wishlistRouter: UnownedRouter<WishlistRoute>?
    var cancellables: [AnyCancellable] = []
    @Published var itemIndex: Int
    init(router: UnownedRouter<HomeRoute>, itemIndex: Int) {
        self.router = router
        self.wishlistRouter = nil
        self.itemIndex = itemIndex
    }
    init(router: UnownedRouter<WishlistRoute>, itemIndex: Int) {
        self.wishlistRouter = router
        self.router = nil
        self.itemIndex = itemIndex
    }
    enum Action {
        case pop
    }
    func send(action: Action) {
        switch action {
        case .pop:
            if router != nil {
                router?.trigger(.pop)
            }
            else {
                wishlistRouter?.trigger(.pop)
            }
            
        }
    }
}
