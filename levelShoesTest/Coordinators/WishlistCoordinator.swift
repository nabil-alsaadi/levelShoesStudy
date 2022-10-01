//
//  WishlistCoordinator.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 02/10/2022.
//

import Foundation
import UIKit
import SwiftUI
import XCoordinator
import Combine
enum WishlistRoute: Route {
    case wishlist
    case productDetails(itemIndex: Int)
    case pop
    case dismiss
}

class WishlistCoordinator: NavigationCoordinator<WishlistRoute> {
    @ObservedObject var globals: Globals
    var cancelSet: Set<AnyCancellable> = []
    init(globals: Globals) {
        self.globals = globals
        super.init(initialRoute: .wishlist)
    }
    func hideNavigation() {
        self.rootViewController.navigationBar.isHidden = true
    }
    func showNavigation() {
        self.rootViewController.navigationBar.isHidden = false
    }
    // MARK: Overrides

    override func prepareTransition(for route: WishlistRoute) -> NavigationTransition {
        switch route {
        case .wishlist:
            hideNavigation()
            let vm = WishlistViewModel(router: unownedRouter)
            let view = WishlistView(viewModel: vm).environmentObject(globals)
            let vc = UIHostingController(rootView: view)
            return .push(vc,animation: .modal)
        case .productDetails(let itemIndex):
            let vm = ProductDetailsViewModel(router: unownedRouter, itemIndex: itemIndex)
            let view = ProductDetailsView(viewModel: vm).environmentObject(globals)
            let vc = UIHostingController(rootView: view)
            return .push(vc)
        case .pop:
            return .pop()
        case .dismiss:
            return .dismiss()
        }
    }

}
