//
//  HomeView.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 17/01/24.
//

import SwiftUI

struct HomeView: View {
    @State private var tabItems: [String] = []
    @State private var selectedTabCategory: AppTabCategory = .home
    
    init() {
        // Hide the default UITabBar appearance
        //
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selectedTabCategory) {
                DashboardView()
                    .tag(AppTabCategory.home)
                FavoriteView()
                    .tag(AppTabCategory.favorite)
                Text("Tab Content 2").tabItem { /*@START_MENU_TOKEN@*/Text("Tab Label 2")/*@END_MENU_TOKEN@*/ }.tag(3)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.gray)
            }
            
            HStack(spacing: 0) {
                AppTabItemView(
                    tabItemName: "Home",
                    tabItemImage: "house.fill",
                    selectedTabItem: selectedTabCategory,
                    tabItemTag: .home
                ) { tabCategory in
                    withAnimation { selectedTabCategory = tabCategory }
                }
                
                Spacer(minLength: 0)
                
                AppTabItemView(
                    tabItemName: "Favorite",
                    tabItemImage: "star.fill",
                    selectedTabItem: selectedTabCategory,
                    tabItemTag: .favorite
                ) { tabCategory in
                    withAnimation { selectedTabCategory = tabCategory }
                }
                
                Spacer(minLength: 0)
                
                AppTabItemView(
                    tabItemName: "Account",
                    tabItemImage: "person.fill",
                    selectedTabItem: selectedTabCategory,
                    tabItemTag: .account
                ) { tabCategory in
                    withAnimation { selectedTabCategory = tabCategory }
                }
            }
            .padding(.horizontal)
            .background(Color.appSecondary)
        }
    }
}

#Preview {
    HomeView()
}
