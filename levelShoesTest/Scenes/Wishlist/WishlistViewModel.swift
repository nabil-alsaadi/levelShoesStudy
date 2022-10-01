//
//  WishlistView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 01/10/2022.
//

import Foundation
import XCoordinator
import Combine
class WishlistViewModel: ObservableObject {
    let router: UnownedRouter<WishlistRoute>
    var cancellables: [AnyCancellable] = []
    @Published var itemsResponse : ItemsReponse?
    init(router: UnownedRouter<WishlistRoute>) {
        self.router = router

    }
    enum Action {
        case dismiss
        case productDetails(itemIndex: Int)
    }
    func send(action: Action) {
        switch action {
        case .dismiss:
            router.trigger(.dismiss)
        case .productDetails(let itemIndex):
            router.trigger(.productDetails(itemIndex: itemIndex))
        }
    }
}
