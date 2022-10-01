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
    case productDetails
}

class HomeCoordinator: NavigationCoordinator<HomeRoute> {

    init() {
        super.init(initialRoute: .home)
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
            let view = HomeView()
//                .onAppear {
//                self.hideNavigation()
//            }
            let vc = UIHostingController(rootView: view)
            return .push(vc)
        case .productDetails:
            let view = ProductDetailsView()
            let vc = UIHostingController(rootView: view)
            return .push(vc)
        }
    }

}
