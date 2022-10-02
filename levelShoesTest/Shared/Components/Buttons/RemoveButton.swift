//
//  RemoveButton.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 02/10/2022.
//

import SwiftUI

struct RemoveButton: View {
    var action: () -> Void = {}
    var body: some View {
        HStack {
            Button {
                action()
            } label: {
                HStack {
                    Image("trash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20,height: 20)
                }
                Text("Remove")
                    .foregroundColor(.gray)
                    .underline()
            }
        }
    }
}

struct RemoveButton_Previews: PreviewProvider {
    static var previews: some View {
        RemoveButton()
    }
}
