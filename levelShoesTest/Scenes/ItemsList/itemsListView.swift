//
//  itemsListView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 01/10/2022.
//

import SwiftUI
struct itemsListView: View {
    @ObservedObject var viewModel: ItemsListViewModel
    let columns = [GridItem(.flexible(),spacing: 25), GridItem(.flexible(),spacing: 25)]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                if let items = viewModel.items {
                    ForEach(0 ..< items.count,id: \.self) { index in
                        Button {
                            viewModel.send(action: .productDetails(itemIndex: index) )
                        } label: {
                            ProductCellView(item: items[index])
                        }
                    }
                }
            }
            .padding(20)
        }
    }
}

struct itemsListView_Previews: PreviewProvider {
    static var previews: some View {
        itemsListView(viewModel: ItemsListViewModel(router: HomeCoordinator().unownedRouter, items: [Item.testItem(),Item.testItem2()]) ).environmentObject(Globals())
    }
}
