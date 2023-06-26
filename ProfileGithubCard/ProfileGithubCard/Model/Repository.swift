//
//  GithubUser.swift
//  ProfileGithubCard
//
//  Created by Nick Theodoridis on 5/6/23.
//
import Foundation


struct Repository: Hashable,Codable{
    let name: String
}


class ViewModel: ObservableObject{
    
    @Published var repos: [Repository] = []
    
    func fetch(userInputName: String){
        guard let url = URL(string: "https://api.github.com/users/\(userInputName)/repos") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data,_,error in
            guard let data = data, error == nil else{
                return
            }
            
            
            do{
                let repos = try JSONDecoder().decode([Repository].self, from: data)
                DispatchQueue.main.async {
                    self?.repos = repos
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    
}
