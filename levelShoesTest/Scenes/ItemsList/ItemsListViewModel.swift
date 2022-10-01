//
//  ItemsListViewModel.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 01/10/2022.
//

import Foundation
import XCoordinator
import Combine
class ItemsListViewModel: ObservableObject {
    let router: UnownedRouter<HomeRoute>
    var cancellables: [AnyCancellable] = []
    @Published var items : [Item] = []
    init(router: UnownedRouter<HomeRoute>,items: [Item]) {
        self.router = router
        self.items = items
    }
    enum Action {
        case productDetails(itemIndex: Int)
    }
    func send(action: Action) {
        switch action {
        case .productDetails(let itemIndex):
            router.trigger(.productDetails(itemIndex: itemIndex) )
        }
    }
}
