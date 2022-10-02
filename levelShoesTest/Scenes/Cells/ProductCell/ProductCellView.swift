//
//  ProductCellView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 30/09/2022.
//

import SwiftUI

struct ProductCellView: View {
    @EnvironmentObject var globals: Globals
    var item: Item
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                VStack {
                    UrlImageView(urlString: item.image, imageScale: .fit)
                        .padding(.vertical,20)
                }
                .frame(height:250)
                .background(Color.white)
                .clipped()
                .shadow(color: .shadowColor,radius: 5,y: 10)
                VStack(alignment: .leading) {
                    P(item.brand,fontWeight: .bold)
                    H2(item.name, foregroundColor: .gray)
                    HStack {
                        P("\(item.price) \(globals.itemsResponse.currency)",foregroundColor: .gray)
                        if let originalPrice = item.originalPrice {
                            CrosslineTextView(title: "\(originalPrice) \(globals.itemsResponse.currency)")
                        }
                    }.padding(.top,5)
                }
                .padding(.top)
                Spacer()
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
                    BookmarkButtonView(selected: item.isFav ?? false) {
                        if item.isFav ?? false {
                            globals.removeFromWishlist(item: item)
                        }
                        else {
                            globals.addToWishList(item: item)
                        }
                        
                    }
                    
                }
                .padding(10)
                Spacer()
            }
        }
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        HStack(alignment: .top) {
            ProductCellView(item: Item.testItem())
            ProductCellView(item: Item.testItem2())
        }
        .padding().environmentObject(Globals())
        
    }
}
