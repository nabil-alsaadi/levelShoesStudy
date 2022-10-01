//
//  ProgressIndecatorView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 02/10/2022.
//

import SwiftUI

struct ProgressIndecatorView: View {
    @EnvironmentObject var globals: Globals
    var body: some View {
        HStack {
            Spacer()
            ProgressView()
            Spacer()
        }
        
    }
}

struct ProgressIndecatorView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressIndecatorView().environmentObject(Globals())
    }
}
