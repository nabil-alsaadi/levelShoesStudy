//
//  WishlistRowView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 02/10/2022.
//

import SwiftUI

struct WishlistRowView: View {
    @EnvironmentObject var globals: Globals
    var item: Item
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            VStack {
                HStack(alignment: .top) {
                    VStack {
                        UrlImageView(urlString: item.image, imageScale: .fit)
                            .frame(width: 150,height: 200)
                            .padding()
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
                            
                        }
                        .padding(10)
                    })
                    VStack(alignment: .leading) {
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
                        HStack {
                            Spacer()
                            RemoveButton {
                                globals.removeFromWishlist(item: item)
                            }
                            Spacer()
                        }
                        

                    }.padding(.horizontal,10)
                    
                }
                .padding(.vertical,30)
                Seperator()
            }
            .frame(maxHeight:400)
        }

        
    }
}

struct WishlistRowView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistRowView(item: Item.testItem(), action: {}).environmentObject(Globals())
    }
}
