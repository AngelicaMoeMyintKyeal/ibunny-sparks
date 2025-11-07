//
//  HomeView.swift
//  ibunny-sparks
//
//  Created by Htet Myat Moe Myint Kyeal on 07/11/25.
//

import SwiftUI

struct HomeView: View {
    @State var isPulsing = false
    @AppStorage("appUserName") var appUserName = "iBunny"

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Spacer()
                
                Image("app-name-icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .padding(.bottom, 20)
                
                Image("welcome-bunny-icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    .scaleEffect(isPulsing ? 1.15 : 1.0)
                    .animation(
                        .easeInOut(duration: 0.8).repeatForever(),
                        value: isPulsing
                    )
                    .task { isPulsing = true }
                
                Text("Got any idea, [\(appUserName)](https://www.linkedin.com/in/htet-myak-moe-myint-kyal99/)?")
                    .padding()
                    .foregroundStyle(.orange)
                
                Spacer()
            }
            .padding()
            
            #if !os(macOS)
            .navigationBarHidden(true) // This will only compile for iOS
            #endif
        }
    }
}
