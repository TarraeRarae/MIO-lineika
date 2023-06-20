//
//  ModifiedMethod.swift
//  MIO-lineika
//
//  Created by Misha Fedorov on 21.06.2023.
//

import SwiftUI

struct ModifiedMethodView: View {
    
    @State var model: ConclusionModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                VStack(spacing: 12) {
                    ResultHeaderBubbleView(model: model)
                    
                    ResultBubbleContainer(image: Asset.ModifiedMethod.t1.image)
                    
                    ResultBubbleContainer(image: Asset.ModifiedMethod.t2.image)

                    // MARK: - Table
                    
                    BubbleContainerView {
                        VStack(alignment: .leading) {
                            Text("Вспомогательная таблица")
                                .font(FontFamily.Nunito.medium.swiftUIFont(size: 16))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                Image(uiImage: Asset.ModifiedMethod.t3.image)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                    
                    // MARK: - Table
                    
                    BubbleContainerView {
                        VStack(alignment: .leading) {
                            Text("Основная таблица")
                                .font(FontFamily.Nunito.medium.swiftUIFont(size: 16))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                Image(uiImage: Asset.ModifiedMethod.t4.image)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                }
                
                VStack(spacing: 12) {
                    ResultBubbleContainer(image: Asset.ModifiedMethod.t5.image)
                    
                    ResultBubbleContainer(image: Asset.ModifiedMethod.t6.image)
                    
                    ResultBubbleContainer(image: Asset.ModifiedMethod.t7.image)

                    ResultBubbleContainer(image: Asset.ModifiedMethod.t8.image)

                    ResultBubbleContainer(image: Asset.ModifiedMethod.t9.image)


                    // MARK: - Table
                    
                    BubbleContainerView {
                        VStack(alignment: .leading) {
                            Text("Перестроение основной таблицы")
                                .font(FontFamily.Nunito.medium.swiftUIFont(size: 16))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                Image(uiImage: Asset.ModifiedMethod.t10.image)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                }
                
                VStack(spacing: 12) {
                    ResultBubbleContainer(image: Asset.ModifiedMethod.t11.image)

                    ResultBubbleContainer(image: Asset.ModifiedMethod.t12.image)

                    ResultBubbleContainer(image: Asset.ModifiedMethod.t13.image)

                    ResultBubbleContainer(image: Asset.ModifiedMethod.t14.image)

                    // MARK: - Table
                    
                    BubbleContainerView {
                        VStack(alignment: .leading) {
                            Text("Перестроение основной таблицы")
                                .font(FontFamily.Nunito.medium.swiftUIFont(size: 16))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                Image(uiImage: Asset.ModifiedMethod.t15.image)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                }
                
                VStack(spacing: 12) {
                    ResultBubbleContainer(image: Asset.ModifiedMethod.t16.image)

                    ResultBubbleContainer(image: Asset.ModifiedMethod.t17.image)

                    ResultBubbleContainer(image: Asset.ModifiedMethod.t18.image)

                    ResultBubbleContainer(image: Asset.ModifiedMethod.t19.image)

                    // MARK: - Table
                    
                    BubbleContainerView {
                        VStack(alignment: .leading) {
                            Text("Перестроение основной таблицы")
                                .font(FontFamily.Nunito.medium.swiftUIFont(size: 16))
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                Image(uiImage: Asset.ModifiedMethod.t20.image)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 20)
                    
                    ResultBubbleContainer(image: Asset.ModifiedMethod.t21.image)

                    ResultBubbleContainer(image: Asset.ModifiedMethod.t22.image)

                    ResultBubbleContainer(image: Asset.ModifiedMethod.t23.image, isAnswer: true)
                }
            }
        }
    }
}

struct ModifiedMethod_Previews: PreviewProvider {
    static var previews: some View {
        ModifiedMethodView(
            model: ConclusionModel(
                function: [1, 2, 3, 4],
                constraints: [[1, 2], [1, 2]],
                optimization: .max,
                method: .straightSimplex
            )
        )
    }
}
