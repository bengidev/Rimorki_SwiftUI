//
//  CollectionView+Ext.swift
//  Rimorki
//
//  Created by Bambang Tri Rahmat Doni on 18/01/24.
//

import SwiftUI

extension UICollectionReusableView {
    override open var backgroundColor: UIColor? {
        get { .clear }
        set { }

        // default separators use same color as background
        // so to have it same but new (say red) it can be
        // used as below, otherwise we just need custom separators
        //
        // set { super.backgroundColor = .red }

    }
}

extension View {
    func listBackgroundColor(_ color: Color = .clear) -> some View {
        self.onAppear {
            UICollectionView.appearance().backgroundColor = UIColor(color)
        }
    }
}


