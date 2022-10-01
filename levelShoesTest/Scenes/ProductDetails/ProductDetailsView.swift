//
//  ProductDetailsView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 30/09/2022.
//

import SwiftUI

struct ProductDetailsView: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Image("bookmark")
                            .resizable()
                            .scaledToFit()
                            .frame(height:30)
                    }
                    .padding()
                }
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
                }
                .padding()
                VStack {
                    //Spacer()
                    Image("test")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom,20)
                }
            }//.background(Color.gray.opacity(0.2))
            Spacer()
            Text("SAINT LAURENT")
            Text("SAINT LAURENT")
            Text("2300 AED")
            
            ButtonView(title: "ADD TO BAG") {
                
            }
            .padding()
        }
        
        
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView()
    }
}
