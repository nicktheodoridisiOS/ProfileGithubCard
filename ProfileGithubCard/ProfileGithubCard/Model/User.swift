//
//  GithubUser.swift
//  ProfileGithubCard
//
//  Created by Nick Theodoridis on 5/6/23.
//

import Foundation

struct User: Codable{
    let avatarUrl: String?
    let name: String?
    let login: String?
    let bio: String?
    let publicRepos: Int?
    let followers: Int?
    let following: Int?
    
    
}

func getUser(userInputName: String) async throws -> User{
    let endpoint = "https://api.github.com/users/\(userInputName)"
    
    
    guard let url  = URL(string: endpoint) else {
        throw GHError.invalideURL //Create a URL object
            
    }
    
    let (data , response) = try await URLSession.shared.data(from:url) // Got data from URL
    
    guard let response  = response as? HTTPURLResponse, response.statusCode == 200 else{
        throw GHError.invalideResponse
    } // Check the response of the request
    
    do{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase // The Snake Case helps me to recognize the data who has underscore
        return try decoder.decode(User.self, from: data)
    } catch{
        throw GHError.invalidData
    }
}
