//
//  Color.swift
//  Yuber
//
//  Created by Honnier on 7/11/23.
//

import SwiftUI


extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    let primaryTextColor = Color("PrimaryTextColor")
}
