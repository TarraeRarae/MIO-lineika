//
//  TheoryRootView.swift
//  MIO-lineika
//
//  Created by Misha Fedorov on 17.06.2023.
//

import SwiftUI

struct TheoryRootView: View {
    
    @State var items = TheoryItems.allCases
    
    var body: some View {
        ScrollView {
            VStack {
                BubbleContainerView {
                    Image(uiImage: Asset.baseInformation.image)
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 20)
                
                ForEach(items, id: \.id) { item in
                    TheoryItem(item)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 150)
        }
    }
    
    
    @ViewBuilder func TheoryItem(_ item: TheoryItems) -> some View {
        if !item.isEnabled {
            BubbleContainerView {
                HStack {
                    Text(item.title)
                        .lineLimit(1)
                        .font(FontFamily.Nunito.bold.swiftUIFont(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(uiImage: Asset.Arrows.chevronRight.image)
                }
                .foregroundColor(Color(red: 0.17, green: 0.13, blue: 0.19, opacity: 0.4))
            }
            .padding(.horizontal, 20)
        } else {
            NavigationLink {
                TheoryDetailView(item: item)
                    .baseToolbar(item.title)
            } label: {
                BubbleContainerView {
                    HStack {
                        Text(item.title)
                            .lineLimit(1)
                            .font(FontFamily.Nunito.bold.swiftUIFont(size: 16))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Image(uiImage: Asset.Arrows.chevronRight.image)
                    }
                }
                .padding(.horizontal, 20)
            }
            .buttonStyle(.plain)
        }
    }
}

struct TheoryRootView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TheoryRootView()
                .navigationTitle("Теоретические материалы")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
