//
//  NavigationBarView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 01/10/2022.
//

import SwiftUI
enum NavigationType {
    case home
    case details
    case bookmarks
}
struct NavigationBarView: View {
    var title: String
    var type: NavigationType
    var isFav: Bool = false
    var rightAction: () -> Void = {}
    var leftAction: () -> Void = {}
    
    var body: some View {
        VStack {
            if type == .home {
                HStack {
                    Spacer()
                    Text(title)
                    Spacer()
                }
                .overlay(alignment: .trailing) {
                    Button {
                        rightAction()
                    } label: {
                        Image("bookmark")
                            .resizable()
                            .scaledToFit()
                            .frame(height:30)
                    }
                }
                .padding(.horizontal)
                .shadow(color: .white,radius: 0)
                
                
            }
            else if type == .bookmarks {
                HStack {
                    Spacer()
                    Text(title)
                    Spacer()
                }
                .overlay(alignment: .trailing) {
                    Button {
                        rightAction()
                    } label: {
                        Image("x")
                            .resizable()
                            .scaledToFit()
                            .frame(height:30)
                    }
                }
                .padding(.horizontal)
                .shadow(color: .white,radius: 0)
            }
            else if type == .details {
                HStack {
                    Button {
                        leftAction()
                    } label: {
                        Image("back")
                            .resizable()
                            .scaledToFit()
                            .frame(height:30)
                    }
                    Spacer()
                    Text(title)
                    Spacer()
                    BookmarkButtonView(selected: isFav) {
                        rightAction()
                    }
//                    Button {
//                        rightAction()
//                    } label: {
//                        Image("bookmark")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height:30)
//                    }
                }
                .padding(.horizontal)
                .shadow(color: .white,radius: 0)
            }
            
        }
        .frame(height:50)
        .background(Color.white)
        .clipped()
        .shadow(color: type == .details ? .white : .shadowColor, radius: 3,y: 3)
        
    }
}

struct NavigationBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarView(title: "test title",type: .details)
    }
}
