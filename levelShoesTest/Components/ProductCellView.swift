//
//  ProductCellView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 30/09/2022.
//

import SwiftUI

struct ProductCellView: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                //Spacer()
                Image("test")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom,20)
            }
            .background(Color.white)
            .clipped()
            .shadow(color: .shadowColor,radius: 20,y: 4)
            
            Text("SAINT LAURENT")
            Text("SAINT LAURENT")
            Text("2300 AED")
        }
        .overlay(alignment: .top, content: {
            HStack(alignment: .top) {
                FlexibleView(data: [
                    "KIDS UNISEX", "NEW", "SALE"
                  ],
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
            ProductCellView()
            ProductCellView()
        }
        .padding()
        
    }
}
