//
//  TagView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 30/09/2022.
//

import SwiftUI

struct TagView: View {
    var title: String
    var body: some View {
        
            Text(title)
                .font(.caption2)
                .padding(5)
                .background(
                  RoundedRectangle(cornerRadius: 5)
                    .fill(Color.tagColor)
                 )
        
        
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(title: "test")
    }
}
