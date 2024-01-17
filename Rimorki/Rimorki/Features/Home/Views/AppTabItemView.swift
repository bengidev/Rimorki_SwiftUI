//
//  AppTabItemView.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 17/01/24.
//

import SwiftUI

enum AppTabCategory: String, CaseIterable {
    case home
    case favorite
    case account
}

struct AppTabItemView: View {
    var tabItemName: String?
    var tabItemImage: String?
    let selectedTabItem: AppTabCategory
    let tabItemTag: AppTabCategory
    var tabItemHandler: ((AppTabCategory) -> Void)?
    
    var body: some View {
        Button {
            tabItemHandler?(tabItemTag)
        } label: {
            HStack(spacing: 8.0) {
                Image(systemName: (tabItemImage ?? "house.fill"))
                    .foregroundStyle(
                        selectedTabItem == tabItemTag ?
                        Color.appSecondary :
                            Color.gray
                    )
                    .padding(10.0)
                    .background(
                        selectedTabItem == tabItemTag ?
                        Color.appPrimary :
                            Color.clear
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 10.0))
                
                Text(
                    selectedTabItem == tabItemTag ?
                    (tabItemName ?? "Home"):
                        ""
                )
                .font(.system(.headline, design: .rounded))
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AppTabItemView(selectedTabItem: .home, tabItemTag: .home)
}
