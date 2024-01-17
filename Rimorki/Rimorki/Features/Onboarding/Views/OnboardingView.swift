//
//  OnboardingView.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 17/01/24.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage(AppUserDefaults.hasOnboardingCompleted.rawValue) var hasCompletedOnboarding: Bool = false
    
    @State private var blurRadius: CGFloat = 10.0
    @State private var scale: CGFloat = 0.9
    @State private var opacity: Double = 0.0
    @State private var blurRadiusTwo: CGFloat = 10.0
    @State private var scaleTwo: CGFloat = 0.9
    @State private var opacityTwo: Double = 0.0
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.appSecondary
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    Text("Welcome to Rimorki!")
                        .font(.system(.largeTitle, design: .rounded).bold())
                    
                    Text("Embark on an exciting journey through the universe of Rick and Morty with our comprehensive character database. Explore, learn, and discover new facts about your favorite characters every day.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(Color.gray)
                        .padding(.vertical, 10.0)
                        .padding(.horizontal, 10.0)
                    
                    Spacer()
                    
                    Button(action: didTapGetStarted) {
                        Text("Get Started")
                            .frame(
                                maxWidth: geo.size.width * 0.4,
                                maxHeight: geo.size.height * 0.07
                            )
                            .background(
                                Color.appPrimary,
                                in: RoundedRectangle(cornerRadius: 15.0)
                            )
                            .shadow(radius: 5.0)
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                }
                .frame(
                    maxWidth: geo.size.width * 0.9,
                    maxHeight: geo.size.height * 0.5
                )
                .background(
                    Color.white.opacity(0.8),
                    in: RoundedRectangle(cornerRadius: 25.0)
                )
                .position(
                    x: geo.size.width / 2,
                    y: geo.size.height * 0.7
                )
                .blur(radius: blurRadiusTwo)
                .scaleEffect(scaleTwo)
                .opacity(opacityTwo)
                .drawingGroup() // Raster like in UIKit
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            blurRadiusTwo = 0.0
                            scaleTwo = 1.0
                            opacityTwo = 1.0
                        }
                    }
                }
                
                Image(.onboarding)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(
                        maxWidth: geo.size.width,
                        maxHeight: geo.size.height * 0.3
                    )
                    .padding()
                    .position(
                        x: geo.size.width / 2,
                        y: geo.size.height * 0.25
                    )
                    .shadow(color: .black, radius: 5.0)
                    .blur(radius: blurRadius)
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .drawingGroup() // Raster like in UIKit
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            blurRadius = 0.0
                            scale = 1.0
                            opacity = 1.0
                        }
                    }
            }
        }
    }
}

private extension OnboardingView {
    private func didTapGetStarted() -> Void {
        withAnimation {
            hasCompletedOnboarding = true
        }
    }
}


#Preview {
    OnboardingView()
}
