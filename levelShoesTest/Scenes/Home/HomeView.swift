//
//  HomeView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 30/09/2022.
//

import SwiftUI
struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    let columns = [GridItem(.flexible(),spacing: 25), GridItem(.flexible(),spacing: 25)]
    var body: some View {
        VStack {
            HStack {
                Text("NEW IN")
            }
            ScrollView {
                LazyVGrid(columns: columns,spacing: 20) {
                    if let items = viewModel.itemsResponse?.items {
                        ForEach(items, id: \.self) { item in
                            Button {
                                viewModel.send(action: .productDetails)
                            } label: {
                                ProductCellView(item: item)
                            }
                        }
                    }
                }
                .padding(20)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(router: HomeCoordinator().unownedRouter) )
    }
}
