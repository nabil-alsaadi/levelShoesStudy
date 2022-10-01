//
//  Seperator.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 02/10/2022.
//

import SwiftUI

struct Seperator: View {
    var color: Color = .lightGray
    var height: Double = 1
    var body: some View {
        HStack {
            Spacer()
        }
        .frame(height:height)
        .background(color)
    }
}

struct Seperator_Previews: PreviewProvider {
    static var previews: some View {
        Seperator()
            .background(Color.gray)
    }
}
