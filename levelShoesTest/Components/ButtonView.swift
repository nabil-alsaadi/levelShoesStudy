//
//  ButtonView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 30/09/2022.
//

import SwiftUI

struct ButtonView: View {
    var title: String
    var action: () -> ()
    var body: some View {
        Button {
            
        } label: {
            HStack {
                Spacer()
                Text(title)
                    .foregroundColor(Color.white)
                Spacer()
            }
            .padding()
            
            .frame(height:60)
            
            .background(Color.black)
            .cornerRadius(5)
        }

        
        
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "ADD TO BAG", action: {
            
        }).padding()
    }
}
