//
//  MainView.swift
//  ibunny-sparks
//
//  Created by Htet Myat Moe Myint Kyeal on 07/11/25.
//

import SwiftUI

enum ContentTab: String, Hashable {
    case home, ideas, settings
}

struct MainContentView: View {
    @AppStorage("tab") var tab = ContentTab.home
    @AppStorage("appearance") var appearance = ""
    @State var viewModel = IdeaViewModel()

    var body: some View {
        TabView(selection: $tab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(ContentTab.home)

            IdeasView()
                .tabItem {
                    Label("Ideas", systemImage: "list.bullet")
                }
                .tag(ContentTab.ideas)

            SettingsView(appearance: $appearance)
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(ContentTab.settings)
        }
        .environment(viewModel)
        .preferredColorScheme(appearance == "dark" ? .dark : appearance == "light" ? .light : nil)
    }
}
