//
//  YuberApp.swift
//  Yuber
//
//  Created by Honnier on 5/11/23.
//

import SwiftUI

@main
struct YuberApp: App {
    @StateObject var viewModel = LocationSearchViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
        }
    }
}
