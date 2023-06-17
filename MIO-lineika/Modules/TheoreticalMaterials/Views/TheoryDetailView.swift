//
//  TheoryDetailView.swift
//  MIO-lineika
//
//  Created by Misha Fedorov on 17.06.2023.
//

import SwiftUI

struct TheoryDetailView: View {
    
    @State var item: TheoryItems
    
    var body: some View {
        ScrollView {
            BubbleContainerView {
                content
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.bottom, 100)
        }
    }
    
    @ViewBuilder var content: some View {
        if let image = item.contenImage {
            image
        } else {
            Text("Uuups")
        }
    }
}

struct TheoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TheoryDetailView(item: .graphicMethod)
    }
}
