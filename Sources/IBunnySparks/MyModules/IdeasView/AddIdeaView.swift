//
//  AddIdeaView.swift
//  ibunny-sparks
//
//  Created by Htet Myat Moe Myint Kyeal on 07/11/25.
//

import SwiftUI

struct AddIdeaView: View {
    @Environment(IdeaViewModel.self) var viewModel
    @Environment(\.dismiss) var dismiss
    @State var title = ""
    @State var concept = ""
    @State var date = Date()
    @State var useCustomDate = false
    
    var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !concept.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // Simple Image Placeholder Section
                Section(header: Text("Idea Image")) {
                    VStack(alignment: .center, spacing: 12) {
                        Image("idea-img-icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .foregroundColor(.secondary)
                            .padding(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                            )
                        
                        Text("Custom images coming soon!")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
                
                Section(header: Text("Idea Details")) {
                    TextField("Title", text: $title)
                        .textFieldStyle(.roundedBorder)
                    
                    Toggle("Set custom date", isOn: $useCustomDate)
                    
                    if useCustomDate {
                        DatePicker("Date & Time", selection: $date)
                    }
                }
                
                Section(header: Text("Novel Concept")) {
                    TextEditor(text: $concept)
                        .frame(minHeight: 120)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                        )
                }
            }
            .navigationTitle("New Idea")
            #if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newIdea = Idea(
                            title: title.trimmingCharacters(in: .whitespacesAndNewlines),
                            concept: concept.trimmingCharacters(in: .whitespacesAndNewlines),
                            date: useCustomDate ? date : Date()
                        )
                        viewModel.ideas.insert(newIdea, at: 0)
                        dismiss()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
}
