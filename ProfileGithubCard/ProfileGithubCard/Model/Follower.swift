//
//  Follower.swift
//  ProfileGithubCard
//
//  Created by Nick Theodoridis on 27/6/23.
//

import Foundation


struct Follower: Hashable,Codable{
    let login: String?
    let avatar_url: String?
    
}


class FollowerModel: ObservableObject{
    
    @Published var follower: [Follower] = []
    
    func fetch(userInputName: String){
        guard let url = URL(string: "https://api.github.com/users/\(userInputName)/followers") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data,_,error in
            guard let data = data, error == nil else{
                return
            }
            
            
            do{
                let follower = try JSONDecoder().decode([Follower].self, from: data)
                DispatchQueue.main.async {
                    self?.follower = follower
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
    
}

