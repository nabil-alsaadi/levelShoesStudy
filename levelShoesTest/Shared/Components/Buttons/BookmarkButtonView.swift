//
//  BookmarkButtonView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 01/10/2022.
//

import SwiftUI

struct BookmarkButtonView: View {
    var selected: Bool
    var action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            if selected {
                Image("bookmark_Filled")
                    .resizable()
                    .scaledToFit()
                    .frame(height:30)
            }
            else {
                Image("bookmark")
                    .resizable()
                    .scaledToFit()
                    .frame(height:30)
            }
            
        }
    }
}

struct BookmarkButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkButtonView(selected: true, action: {})
    }
}
