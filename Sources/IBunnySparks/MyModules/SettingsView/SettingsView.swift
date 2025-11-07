//
//  SettingsView.swift
//  ibunny-sparks
//
//  Created by Htet Myat Moe Myint Kyeal on 07/11/25.
//

import SwiftUI

struct SettingsView: View {
    @Binding var appearance: String
    @AppStorage("appUserName") var appUserName = "iBunny"
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section(header: Text("User Name")) {
                    TextField("User Name", text: $appUserName)
                        .foregroundStyle(.secondary)
                }
                
                Section(header: Text("Appearance")) {
                    Picker("Theme", selection: $appearance) {
                        Text("System").tag("")
                        Text("Light").tag("light")
                        Text("Dark").tag("dark")
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
                           let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                            Text("\(version) (\(buildNumber))")
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    HStack {
                        Text("Developed by")
                        Spacer()
                        Text("iBunny")
                            .foregroundColor(.secondary)
                        Image("iBunny-icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

