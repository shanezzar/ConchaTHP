//
//  ViewModel.swift
//  ConchaTHP
//
//  Created by Shanezzar Sharon on 29/03/2022.
//

import Foundation

class ViewModel: ObservableObject {
    
    // MARK: - Observed Variables
    
    @Published var concha: Concha = .empty
    @Published var isLoading: Bool = false
    @Published var errorMessage = ""
    
    
    // MARK: - Methods
    
    func fetch(for url: StartNextURL, _ params: [String: Any]) {
        isLoading = true
        guard let url = URL(string: url.rawValue) else {
            concha = .empty
            errorMessage = "Invalid URL! Please check the URL."
            isLoading = false
            return
        }
        
        let jsonData = try? JSONSerialization.data(withJSONObject: params)
        let task = URLSession.shared.conchaTask(with: url, jsonData: jsonData) { concha, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.concha = .empty
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                    return
                }
            }
            else if let concha = concha {
                DispatchQueue.main.async {
                    self.concha = concha
                    self.isLoading = false
                    self.errorMessage = ""
                    return
                }
            }
            else {
                DispatchQueue.main.async {
                    self.concha = .empty
                    self.errorMessage = "Unknown error! Please try again later."
                    self.isLoading = false
                    return
                }
            }
        }
        task.resume()
    }
}
