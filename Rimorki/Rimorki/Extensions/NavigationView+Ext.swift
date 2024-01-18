//
//  NavigationView+Ext.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 18/01/24.
//

import SwiftUI

func navigationBarFormatTitle(regularFont: UIFont, largeFont: UIFont) {
    
    // this is not the same as manipulating the proxy directly
    let appearance = UINavigationBarAppearance()
    
    // this overrides everything you have set up earlier.
    appearance.configureWithTransparentBackground()
    
    // this only applies to big titles
    appearance.largeTitleTextAttributes = [
        .font : regularFont,
        NSAttributedString.Key.foregroundColor : UIColor.label
    ]
    
    // this only applies to small titles
    appearance.titleTextAttributes = [
        .font : largeFont,
        NSAttributedString.Key.foregroundColor : UIColor.label
    ]
    
    //In the following two lines you make sure that you apply the style for good
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
    UINavigationBar.appearance().standardAppearance = appearance
    
    // This property is not present on the UINavigationBarAppearance
    // object for some reason and you have to leave it til the end
    UINavigationBar.appearance().tintColor = .label
}
