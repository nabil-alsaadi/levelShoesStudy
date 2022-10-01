//
//  HomeView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 30/09/2022.
//

import SwiftUI

struct HomeView: View {
    let columns = [GridItem(.flexible(),spacing: 25), GridItem(.flexible(),spacing: 25)]
    var body: some View {
        VStack {
            HStack {
                Text("NEW IN")
            }
            ScrollView {
                LazyVGrid(columns: columns,spacing: 20) {
                    NavigationLink {
                        ProductDetailsView()
                    } label: {
                        ProductCellView()
                    }
                }
                .padding(20)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
