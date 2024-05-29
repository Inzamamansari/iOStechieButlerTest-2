//
//  ContentView.swift
//  iOStechieButlerTest
//
//  Created by Inzimamul Ansari on 30/04/24.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PostViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.posts.indices, id: \.self) { index in
                    if index == viewModel.posts.count - 1 {
                        PostRow(post: viewModel.posts[index])
                            .onAppear {
                                if index + 1 == viewModel.posts.count && !viewModel.isLoading {
                                    viewModel.fetchPosts()
                                }
                            }
                    } else {
                        PostRow(post: viewModel.posts[index])
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("TechieButler")
            .onAppear {
                viewModel.fetchPosts()
            }
        }
    }
}

struct PostRow: View {
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("ID: \(post.id)")
            Text("Title: \(post.title)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
