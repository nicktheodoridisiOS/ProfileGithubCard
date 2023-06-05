

import Foundation


struct Repository: Codable{
    var name: [String] = []
}

func getRepo() async throws -> Repository{
    let repoUrlString = "https://api.github.com/users/nicktheodoridisios/repos"
    
    
    
    guard let url  = URL(string: repoUrlString) else {
        throw GHError.invalideURL //Create a URL object
            
    }
    
    let (repoData , repoResponse) = try await URLSession.shared.data(from:url) // Got data from URL
    
    guard let repoResponse  = repoResponse as? HTTPURLResponse, repoResponse.statusCode == 200 else{
        throw GHError.invalideResponse
    } // Check the response of the request
    
    do{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase // The Snake Case helps me to recognize the data who has underscore
        return try decoder.decode(Repository.self, from: repoData)
    } catch{
        throw GHError.invalidData
    }
}

