//
//  APICaller.swift
//  Pagination
//
//  Created by Олег Федоров on 26.03.2022.
//

import Foundation

let baseURL = "https://jsonplaceholder.typicode.com"

enum NerworkError: Error {
    case serverError
    case parsError
}

class APICaller {

    var isPaginating = false
    private var userNumber = 1
    
    func fetchData(
        pagination: Bool = false,
        completion: @escaping (Result<[Post], Error>) -> Void
    ) {
        if pagination {
            isPaginating = true
            userNumber += 1
        }
        
        if userNumber > 10 {
            userNumber = 1
        }
        print("DEBUG: Begin: \(userNumber)")
        
        DispatchQueue.global().asyncAfter(
            deadline: .now() + (pagination ? 1.5 : 1)
        ) { [self] in

            guard
                let url = URL(string: "\(baseURL)/users/\(self.userNumber)/posts")
            else { return }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                
                if let error = error {
                    completion(.failure(error))
                }
                
                guard let data = data else {
                    completion(.failure(NerworkError.serverError))
                    return
                }
                
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    completion(.success(posts))
                } catch  {
                    completion(.failure(NerworkError.parsError))
                }
                
            }.resume()
            
            if pagination {
                self.isPaginating = false
                print("DEBUG: End: \(userNumber)")
            }
        }
    }
}
