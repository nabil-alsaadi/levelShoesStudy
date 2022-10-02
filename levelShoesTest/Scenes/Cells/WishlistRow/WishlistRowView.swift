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
                    ZStack {
                        VStack {
                            UrlImageView(urlString: item.image, imageScale: .fit)
                                .frame(width: self.getReact().width * 0.4)
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
                                //.padding(.horizontal, 20)
                                Spacer()
                            }
                            .padding(.leading)
                            Spacer()
                        }
                    }
                    .padding(.horizontal,10)
                    .padding(.bottom,50)
                    VStack(alignment: .leading) {
                        P(item.brand,fontWeight: .bold)
                        H2(item.name, foregroundColor: .gray)
                        HStack {
                            P("\(item.price) \(globals.itemsResponse.currency)",foregroundColor: .gray)
                            if let originalPrice = item.originalPrice {
                                CrosslineTextView(title: "\(originalPrice) \(globals.itemsResponse.currency)")
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
            .frame(maxHeight: getReact().height * 0.5)
        }
    }
}

struct WishlistRowView_Previews: PreviewProvider {
    static var previews: some View {
        WishlistRowView(item: Item.testItem(), action: {}).environmentObject(Globals())
    }
}
