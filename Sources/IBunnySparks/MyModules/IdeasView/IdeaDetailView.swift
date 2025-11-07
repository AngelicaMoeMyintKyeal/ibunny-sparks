//
//  IdeaDetailView.swift
//  ibunny-sparks
//
//  Created by Htet Myat Moe Myint Kyeal on 07/11/25.
//

import SwiftUI

struct IdeaDetailView: View {
    let idea: Idea
    @Environment(IdeaViewModel.self) var viewModel
    @Environment(\.dismiss) var dismiss
    @State var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                idea.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                    )
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(idea.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Date & Time")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text(idea.dateTimeString)
                            .font(.body)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Novel Concept")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        Text(idea.concept)
                            .font(.body)
                    }
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.secondary.opacity(0.3))
                        .padding(.vertical)
                    
                    Button(role: .destructive) {
                        showingDeleteAlert = true
                    } label: {
                        HStack {
                            Image(systemName: "trash")
                            Text("Delete")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            }
        }
#if !os(macOS)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
        }
#endif
        .alert("Delete Idea", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                if let index = viewModel.ideas.firstIndex(where: { $0.id == idea.id }) {
                    viewModel.ideas.remove(at: index)
                }
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete \"\(idea.title)\"? This action cannot be undone.")
        }
    }
}
