//
//  ProductDetailsView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 30/09/2022.
//

import SwiftUI

struct ProductDetailsView: View {
    @EnvironmentObject var globals: Globals
    @ObservedObject var viewModel: ProductDetailsViewModel
    var body: some View {
        VStack {
            if viewModel.itemIndex < globals.itemsResponse.items.count, let item = globals.itemsResponse.items[viewModel.itemIndex] {
                NavigationBarView(title: "", type: .details,isFav: item.isFav ?? false) {
                    if item.isFav ?? false {
                        globals.removeFromWishlist(item: item)
                    }
                    else {
                        globals.addToWishList(item: item)
                    }
                    
                } leftAction: {
                    viewModel.send(action: .pop)
                }
                VStack {
                    HStack(alignment: .top) {
                        FlexibleView(data: item.badges,
                                     spacing: 5,
                                     alignment: .leading
                        ) { item in
                            TagView(title: item)
                        }
                        Spacer()
                    }
                    .padding()
                    VStack {
                        //Spacer()
                        UrlImageView(urlString: item.image, imageScale: .fit)
    //                    Image("test")
    //                        .resizable()
    //                        .scaledToFit()
                            .padding(.bottom,20)
                    }
                }
                Spacer()
                P(item.brand,fontWeight: .bold)
                H2(item.name, foregroundColor: .gray)
                HStack {
                    H2("\(item.price) \(globals.itemsResponse.currency)",foregroundColor: .gray)
                    if let originalPrice = item.originalPrice {
                        H2("\(originalPrice) \(globals.itemsResponse.currency)",foregroundColor: .gray)
                            .overlay(content: {
                                Rectangle()
                                    .fill(.gray)
                                    .frame(height: 1)
                            })
                            
                    }
                }.padding(.top,5)
                
                ButtonView(title: "ADD TO BAG",disabled: item.isInBag ?? false) {
                    globals.addToBag(item: item)
                }
                .padding()
            }
            
        }
        
        
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(viewModel: ProductDetailsViewModel(router: HomeCoordinator().unownedRouter, itemIndex: 0)).environmentObject(Globals())
    }
}
