//
//  HomeView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 30/09/2022.
//

import SwiftUI
struct HomeView: View {
    @EnvironmentObject var globals: Globals
    @ObservedObject var viewModel: HomeViewModel
    let columns = [GridItem(.flexible(),spacing: 25), GridItem(.flexible(),spacing: 25)]
    var body: some View {
        VStack {
            NavigationBarView(title: globals.itemsResponse.title, type: .home,rightAction: {
                viewModel.send(action: .wishlist)
            })
            if let items = globals.itemsResponse.items, items.count > 0 {
                itemsListView(viewModel: ItemsListViewModel(router: viewModel.router, items: items) )
            }
            else {
                Spacer()
                ProgressIndecatorView()
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(router: HomeCoordinator().unownedRouter) ).environmentObject(Globals())
    }
}
