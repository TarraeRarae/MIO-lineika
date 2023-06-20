//
//  ArtificialVariablesView.swift
//  MIO-lineika
//
//  Created by Misha Fedorov on 21.06.2023.
//

import SwiftUI

struct ArtificialVariablesView: View {
    @State var model: ConclusionModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                VStack(spacing: 12) {
                    ResultHeaderBubbleView(model: model)
                    
                    ResultBubbleContainer(image: Asset.ArtificialVariables.a1.image)
                    
                    // MARK: - Table
                    
                    BubbleContainerView {
                        VStack(alignment: .leading) {
                            Text("Симплекс таблица")
                                .font(FontFamily.Nunito.medium.swiftUIFont(size: 16))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                Image(uiImage: Asset.ArtificialVariables.a2.image)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                }
                
                VStack(spacing: 12) {
                    
                    ResultBubbleContainer(image: Asset.ArtificialVariables.a3.image)
                    
                    ResultBubbleContainer(image: Asset.ArtificialVariables.a4.image)
                    
                    BubbleContainerView {
                        VStack(alignment: .leading) {
                            Text("Симплекс таблица")
                                .font(FontFamily.Nunito.medium.swiftUIFont(size: 16))
                            Text("Новый базис состоит из дополнительных векторов А3 и А5")
                                .font(FontFamily.Nunito.light.swiftUIFont(size: 12))
                                .foregroundColor(Color(hex: 0x2D2031))
                            ScrollView(.horizontal, showsIndicators: false) {
                                Image(uiImage: Asset.ArtificialVariables.a5.image)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                    
                    ResultBubbleContainer(image: Asset.ArtificialVariables.a6.image)
                    
                    ResultBubbleContainer(image: Asset.ArtificialVariables.a7.image)
                    
                    ResultBubbleContainer(image: Asset.ArtificialVariables.a8.image)
                
                    ResultBubbleContainer(image: Asset.ArtificialVariables.a9.image)
                }
                
                VStack(spacing: 12) {
                    
                    BubbleContainerView {
                        VStack(alignment: .leading) {
                            Text("Симплекс таблица")
                                .font(FontFamily.Nunito.medium.swiftUIFont(size: 16))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                Image(uiImage: Asset.ArtificialVariables.a10.image)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                    
                    ResultBubbleContainer(image: Asset.ArtificialVariables.a11.image)
                    
                    ResultBubbleContainer(image: Asset.ArtificialVariables.a12.image)
                    
                    ResultBubbleContainer(image: Asset.ArtificialVariables.a13.image)
                
                    BubbleContainerView {
                        VStack(alignment: .leading) {
                            Text("Симплекс таблица")
                                .font(FontFamily.Nunito.medium.swiftUIFont(size: 16))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                Image(uiImage: Asset.ArtificialVariables.a14.image)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                    
                    ResultBubbleContainer(image: Asset.ArtificialVariables.a15.image)
                    
                    ResultBubbleContainer(image: Asset.ArtificialVariables.a16.image, isAnswer: true)
                }
            }

        }
    }
}

struct ArtificialVariablesView_Previews: PreviewProvider {
    static var previews: some View {
        ArtificialVariablesView(
            model: ConclusionModel(
                function: [1, 2, 3, 4],
                constraints: [[1, 2], [1, 2]],
                optimization: .max,
                method: .straightSimplex
            )
        )
    }
}
