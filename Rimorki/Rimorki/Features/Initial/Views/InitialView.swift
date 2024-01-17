//
//  InitialView.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 17/01/24.
//

import SwiftUI

struct InitialView: View {
    @AppStorage(AppUserDefaults.hasOnboardingCompleted.rawValue) var hasCompletedOnboarding: Bool = false
    @State private var hasTempValue: Bool = false
    
    init() {
        // For fix the animation by wrapping `@AppStorage`
        // with `@State` property wrapper, when value changed.
        // Source: https://stackoverflow.com/questions/73710154/transition-animation-not-working-in-ios16-but-was-working-in-ios15/73715427#73715427
        //
        _hasTempValue = .init(initialValue: hasCompletedOnboarding)
    }
    
    var body: some View {
        showViewBased(on: hasTempValue)
            .onChange(of: hasCompletedOnboarding) { newValue in
                withAnimation {
                    hasTempValue = newValue
                }
            }
            .onChange(of: hasTempValue) { newValue in
                withAnimation {
                    hasCompletedOnboarding = newValue
                }
            }
    }
}

private extension InitialView {
    @ViewBuilder
    private func showViewBased(on hasValue: Bool) -> some View {
        if hasValue {
            Text("Hello, World!")
                .transition(.opacity)
                .onTapGesture {
                    withAnimation {
                        print("tester")
                        hasTempValue.toggle()
                    }
                }
        } else {
            OnboardingView()
                .transition(.opacity)
        }
    }
}

#Preview {
    InitialView()
}
