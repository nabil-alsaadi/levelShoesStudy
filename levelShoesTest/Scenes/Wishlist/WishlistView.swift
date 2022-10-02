//
//  WishlistView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 01/10/2022.
//

import SwiftUI

struct WishlistView: View {
    @EnvironmentObject var globals: Globals
    @ObservedObject var viewModel: WishlistViewModel
    var body: some View {
        VStack {
            NavigationBarView(title: "WISHLIST (\(globals.wishListCount()))", type: .bookmarks,rightAction: {
                viewModel.send(action: .dismiss)
            })
            ScrollView {
                LazyVStack {
                    ForEach(0..<globals.itemsResponse.items.count,id: \.self) { index in
                        let item = globals.itemsResponse.items[index]
                        if item.isFav ?? false {
                            WishlistRowView(item: item) {
                                viewModel.send(action: .productDetails(itemIndex: index))
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

struct WishlistView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistView(viewModel: WishlistViewModel(router: WishlistCoordinator(globals: Globals()).unownedRouter) ).environmentObject(Globals())
    }
}
