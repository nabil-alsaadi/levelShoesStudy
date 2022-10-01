//
//  ProductCellView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 30/09/2022.
//

import SwiftUI

struct ProductCellView: View {
    var item: Item
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                //Spacer()
                UrlImageView(urlString: item.image, imageScale: .fit)
//                Image("test")
//                    .resizable()
//                    .scaledToFit()
                    .padding(.vertical,20)
            }
            .background(Color.white)
            .clipped()
            .shadow(color: .shadowColor,radius: 5,y: 10)
            
            Text(item.brand)
                .foregroundColor(.black)
            Text(item.name)
                .foregroundColor(.black)
            Text("\(item.price) AED")
                .foregroundColor(.black)
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
                Button {
                    
                } label: {
                    Image("bookmark")
                        .resizable()
                        .scaledToFit()
                        .frame(height:30)
                }
                
            }
            .padding(10)
        })
        
    }
}

struct ProductCellView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ProductCellView(item: Item.testItem())
            ProductCellView(item: Item.testItem())
        }
        .padding()
        
    }
}
