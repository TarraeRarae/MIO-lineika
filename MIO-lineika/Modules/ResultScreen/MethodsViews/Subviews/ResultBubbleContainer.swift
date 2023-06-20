//
//  ResultBubbleContainer.swift
//  MIO-lineika
//
//  Created by Misha Fedorov on 18.06.2023.
//

import UIKit
import SwiftUI

struct ResultBubbleContainer: View {
    
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    var body: some View {
        BubbleContainerView {
            HStack {
                Image(uiImage: image)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 20)
    }
}

struct ResultBubbleContainer_Previews: PreviewProvider {
    static var previews: some View {
        ResultBubbleContainer(image: UIImage(named: "i1")!)
    }
}
