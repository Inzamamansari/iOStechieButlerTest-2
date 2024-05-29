//
//  PostViewModel.swift
//  iOStechieButlerTest
//
//  Created by Inzimamul Ansari on 30/04/24.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading: Bool = false
    
    private var currentPage: Int = 1
    private let itemsPerPage = 10
    
    private let apiManager = APIManager.shared
    
    func fetchPosts() {
        self.isLoading = true
        apiManager.fetchPosts(page: currentPage, limit: itemsPerPage) { [weak self] (fetchedPosts, error) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                if let fetchedPosts = fetchedPosts {
                    self.posts.append(contentsOf: fetchedPosts)
                    self.currentPage += 1
                } else if let error = error {
                    print("Error fetching posts: \(error)")
                }
            }
        }
    }
}
