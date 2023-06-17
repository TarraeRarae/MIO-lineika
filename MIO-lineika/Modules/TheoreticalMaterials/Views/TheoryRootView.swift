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
                }
                
                
            }
            .frame(maxWidth: .infinity)
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
