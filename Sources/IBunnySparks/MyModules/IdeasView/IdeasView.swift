//
//  IdeasView.swift
//  ibunny-sparks
//
//  Created by Htet Myat Moe Myint Kyeal on 07/11/25.
//

import SwiftUI

struct IdeasView: View {
    @Environment(IdeaViewModel.self) var viewModel
    @State var showingAddIdea = false
    @State var searchText = ""
    
    var filteredIdeas: [Idea] {
        if searchText.isEmpty {
            return viewModel.ideas
        } else {
            return viewModel.ideas.filter { idea in
                idea.title.localizedCaseInsensitiveContains(searchText) ||
                idea.concept.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if filteredIdeas.isEmpty {
                    VStack(spacing: 20) {
                        Image("idea-img-icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .foregroundColor(.secondary)
                        
                        Text(searchText.isEmpty ? "No ideas yet" : "No matching ideas")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        if searchText.isEmpty {
                            Button("Add Your First Idea") {
                                showingAddIdea = true
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                } else {
                    List {
                        ForEach(filteredIdeas) { idea in
                            NavigationLink(value: idea) {
                                IdeaCardView(idea: idea)
                            }
                        }
//                        .onDelete { offsets in
//                            viewModel.ideas.remove(atOffsets: offsets)
//                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Ideas")
            .navigationDestination(for: Idea.self) { idea in
                IdeaDetailView(idea: idea)
            }
            .searchable(text: $searchText, prompt: "Search ideas...")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showingAddIdea = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddIdea) {
                AddIdeaView()
            }
        }
    }
}

// MARK: - Idea Card View with Dynamic Image
struct IdeaCardView: View {
    let idea: Idea
    
    var body: some View {
        HStack(spacing: 16) {
            idea.image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
                )
            
            VStack(alignment: .leading, spacing: 6) {
                Text(idea.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                
                Text(idea.dateString)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 4)
    }
}
