//
//  ResultHeaderBubbleView.swift
//  MIO-lineika
//
//  Created by Alexey Zubkov on 17.06.2023.
//

import SwiftUI

struct ResultHeaderBubbleView: View {
    var body: some View {
        VStack {
            Text("Some text")
        }
        .background(Color.black)
        .shadow(
            color: Color(
                DesignManager.shared.theme[.background(.shadow)]
            ),
            radius: 100,
            y: 10
        )
        .padding(20)
    }
}

struct ResultBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        ResultHeaderBubbleView()
    }
}
