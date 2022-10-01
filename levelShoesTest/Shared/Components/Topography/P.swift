//
//  P.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 01/10/2022.
//

import SwiftUI

struct P: View {
    var text:String
    var fontWeight:Font.Weight?
    var foregroundColor : Color?
    var alignment:TextAlignment
    init(_ text : String,foregroundColor:Color? = .black,fontWeight:Font.Weight? = nil,alignment:TextAlignment = .leading) {
        self.text = text
        self.fontWeight = fontWeight
        self.foregroundColor = foregroundColor
        self.alignment = alignment
    }
    var body: some View {
        if fontWeight == nil {
            Text(text)
                .font(Font.p)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(alignment)
                .lineLimit(2)
                .foregroundColor(foregroundColor)
        }
        else {
            Text(text)
                .font(Font.p)
                .fontWeight(fontWeight)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(alignment)
                .lineLimit(2)
                .foregroundColor(foregroundColor)
        }
        
    }
}

struct P_Previews: PreviewProvider {
    static var previews: some View {
        P("test")
    }
}
