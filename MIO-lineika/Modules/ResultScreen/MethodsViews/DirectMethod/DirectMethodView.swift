//
//  DirectMethodView.swift
//  MIO-lineika
//
//  Created by Misha Fedorov on 18.06.2023.
//

import SwiftUI

struct DirectMethodView: View {
    
    @State var model: ConclusionModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                VStack(spacing: 12) {
                    ResultHeaderBubbleView(model: model)
                    
                    ResultBubbleContainer(image: Asset.DirectMethod.i1.image)
                    
                    // MARK: - Table
                    
                    BubbleContainerView {
                        VStack(alignment: .leading) {
                            Text("Симплекс таблица")
                                .font(FontFamily.Nunito.medium.swiftUIFont(size: 16))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                Image(uiImage: Asset.DirectMethod.i2.image)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)

                    ResultBubbleContainer(image: Asset.DirectMethod.i3.image)
                    
                    ResultBubbleContainer(image: Asset.DirectMethod.i4.image)
                    
                    ResultBubbleContainer(image: Asset.DirectMethod.i5.image)

                    // MARK: - Table
                    
                    BubbleContainerView {
                        VStack(alignment: .leading) {
                            Text("Симплекс таблица")
                                .font(FontFamily.Nunito.medium.swiftUIFont(size: 16))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                Image(uiImage: Asset.DirectMethod.i6.image)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                    
                    ResultBubbleContainer(image: Asset.DirectMethod.i7.image)
                    
                    ResultBubbleContainer(image: Asset.DirectMethod.i8.image)
                    
                    ResultBubbleContainer(image: Asset.DirectMethod.i9.image)
                    
                    BubbleContainerView {
                        VStack(alignment: .leading) {
                            Text("Симплекс таблица")
                                .font(FontFamily.Nunito.medium.swiftUIFont(size: 16))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                Image(uiImage: Asset.DirectMethod.i10.image)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                    
                }
                
                ResultBubbleContainer(image: Asset.DirectMethod.i11.image)
                
                ResultBubbleContainer(image: Asset.DirectMethod.i12.image)
            }
        }
    }
}

struct DirectMethodView_Previews: PreviewProvider {
    static var previews: some View {
        DirectMethodView(
            model: ConclusionModel(
                function: [1, 2, 3, 4],
                constraints: [[1, 2], [1, 2]],
                optimization: .max,
                method: .straightSimplex
            )
        )
    }
}
