//
//  CoreLoadingViewModifier.swift
//  NYTimes
//
//  Created by Taimur on 20/11/2024.
//

import SwiftUI

struct CoreLoadingViewModifier: ViewModifier {
    var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
            
            if isLoading {
                ZStack (alignment: .center){
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(1.5)
                        .padding(16)
                        .background(.gray)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                }
                .ignoresSafeArea()
            }
        }
    }
}

extension View {
    func showLoader(isLoading: Bool) -> some View {
        self.modifier(CoreLoadingViewModifier(isLoading: isLoading))
    }
}
