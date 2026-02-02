//
//  LaunchView.swift
//  NewsViperSWUI
//
//  Created by Jose Preatorian on 02-02-26.
//

import Foundation
import SwiftUI

struct LaunchView: View {
    @State private var scale: CGFloat = 0.6
    @State private var opacity: Double = 0
    @State private var isActive = false

    var body: some View {
        if isActive {
            HomeView()
        } else {
            VStack(spacing: 20) {
                
                Image(systemName: "film.stack.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.black)
                    .scaleEffect(scale)
                    .opacity(opacity)
          

                Text("World News test")
                    .font(.largeTitle.bold())
                    .foregroundColor(.black)
                    .opacity(opacity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.yellow)
            .ignoresSafeArea()
            .onAppear {
                withAnimation(.easeOut(duration: 1.2)) {
                    scale = 1.0
                    opacity = 1.0
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    LaunchView()
}
