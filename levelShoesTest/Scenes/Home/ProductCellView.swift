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
        VStack(alignment: .leading) {
            VStack {
                UrlImageView(urlString: item.image, imageScale: .fit)
                    .padding(.vertical,20)
            }
            .frame(height:250)
            .background(Color.white)
            .clipped()
            .shadow(color: .shadowColor,radius: 5,y: 10)
            P(item.brand,fontWeight: .bold)
            H2(item.name, foregroundColor: .gray)
            HStack {
                P("\(item.price) \(globals.itemsResponse.currency)",foregroundColor: .gray)
                if let originalPrice = item.originalPrice {
                    //Spacer()
                    P("\(originalPrice) \(globals.itemsResponse.currency)",foregroundColor: .lightGray)
                        .overlay(content: {
                            Rectangle()
                                .fill(.gray)
                                .frame(height: 1)
                        })
                        
                }
            }.padding(.top,5)
            
                
            
            Spacer()
        }
        .overlay(alignment: .top, content: {
            HStack(alignment: .top) {
                FlexibleView(data: item.badges,
                    spacing: 5,
                    alignment: .leading
                  ) { item in
                    TagView(title: item)
                  }
                  //.padding(.horizontal, 20)
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
        })
        //.frame(maxHeight:400)
        
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
