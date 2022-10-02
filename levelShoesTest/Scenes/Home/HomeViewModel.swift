//
//  HomeViewModel.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 01/10/2022.
//

import Foundation
import XCoordinator
import Combine
class HomeViewModel: ObservableObject {
    let router: UnownedRouter<HomeRoute>
    var cancellables: [AnyCancellable] = []
    @Published var itemsResponse : ItemsReponse?
    init(router: UnownedRouter<HomeRoute>) {
        self.router = router
    }
    enum Action {
        case wishlist
    }
    func send(action: Action) {
        switch action {
        case .wishlist:
            router.trigger(.wishlist)
        }
    }
}
