//
//  HomeView.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 17/01/24.
//

import SwiftUI

struct HomeView: View {
    @State private var tabItems: [String] = []
    @State private var selectedTab = 0
    
    init() {
        // Hide the default UITabBar
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: .constant(1)) {
                Text("Tab Content 1").tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 1")/*@END_MENU_TOKEN@*/ }.tag(1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray)
                Text("Tab Content 2").tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 2")/*@END_MENU_TOKEN@*/ }.tag(2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray)
            }
            
            Spacer(minLength: 10.0)
            
            HStack(spacing: 0) {
                Button {
                    withAnimation(.easeInOut) {
                        selectedTab = 0
                    }
                } label: {
                    HStack(spacing: 8.0) {
                        Image(systemName: "house.fill")
                            .foregroundStyle(selectedTab == 0 ? Color.white : Color.black.opacity(0.35))
                            .padding(10.0)
                            .background(selectedTab == 0 ? Color.black : Color.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        
                        Text(selectedTab == 0 ? "Home": "")
                            .foregroundStyle(Color.black)
                    }
                }
                
                Spacer(minLength: 0)
                
                Button {
                    withAnimation(.easeInOut) {
                        selectedTab = 1
                    }
                } label: {
                    HStack(spacing: 8.0) {
                        Image(systemName: "house.fill")
                            .foregroundStyle(selectedTab == 1 ? Color.white : Color.black.opacity(0.35))
                            .padding(10.0)
                            .background(selectedTab == 1 ? Color.black : Color.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        
                        Text(selectedTab == 1 ? "Home": "")
                            .foregroundStyle(Color.black)
                    }
                }
                
                Spacer(minLength: 0)
                
                Button {
                    withAnimation(.easeInOut) {
                        selectedTab = 2
                    }
                } label: {
                    HStack(spacing: 8.0) {
                        Image(systemName: "house.fill")
                            .foregroundStyle(selectedTab == 2 ? Color.white : Color.black.opacity(0.35))
                            .padding(10.0)
                            .background(selectedTab == 2 ? Color.black : Color.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                        
                        Text(selectedTab == 2 ? "Home": "")
                            .foregroundStyle(Color.black)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}
