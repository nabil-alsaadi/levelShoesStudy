//
//  CrosslineTextView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 02/10/2022.
//

import SwiftUI

struct CrosslineTextView: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.p)
            .strikethrough()
            .foregroundColor(.lightGray)
    }
}

struct CrosslineTextView_Previews: PreviewProvider {
    static var previews: some View {
        CrosslineTextView(title: "100 AED")
    }
}
