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
        ItmesService.shared.getItems()
            .sink { completion in
                switch completion {
                case.failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { itemsResponse in
                self.itemsResponse = itemsResponse
            }.store(in: &cancellables)

    }
    enum Action {
        case productDetails
    }
    func send(action: Action) {
        switch action {
        case .productDetails:
            router.trigger(.productDetails)
        }
    }
}
