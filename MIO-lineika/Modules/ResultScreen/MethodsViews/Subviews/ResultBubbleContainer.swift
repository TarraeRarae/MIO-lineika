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
    
    var isAnswer: Bool
    
    init(image: UIImage, isAnswer: Bool = false) {
        self.image = image
        self.isAnswer = isAnswer
    }
    
    var body: some View {
        BubbleContainerView(borderedContainer: isAnswer){
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
        ResultBubbleContainer(image: UIImage(named: "i1")!, isAnswer: true)
    }
}
