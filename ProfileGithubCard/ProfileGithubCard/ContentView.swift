//
//  ContentView.swift
//  ProfileGithubCard
//
//  Created by Nick Theodoridis on 5/6/23.
//

import SwiftUI

struct ContentView: View {
    
    @State  private var user: User?
    @StateObject var repository = ViewModel()
    
    @State  private var isValid = false
    
    @Binding var searchedText:String
    
    var body: some View {
        VStack (spacing: 20){
            
            if(!isValid){
                AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                }placeholder: {
                    Circle()
                        .foregroundColor(.secondary)
                }
                .frame(width: 120,height: 120)
            
                VStack(spacing: 5){
                    Text(user?.name ?? "Name Placeholder")
                        .font(.title)
                        .bold()
                        .font(.title3)
                    
                    Text("@")
                        .foregroundColor(.secondary)
                    + Text(user?.login ?? "Login Placeholder")
                        .foregroundColor(.secondary)
                }
               
                Text(user?.bio ?? "Bio Placeholder")
                    .multilineTextAlignment(.center)
                    .padding()
                

                HStack(spacing: 50){
                    VStack{
                        Text(String(user?.publicRepos ?? 0))
                            .font(.title)
                            .bold()
                        Text("Public Repos")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                    
                    VStack{
                        Text(String(user?.followers ?? 0))
                            .font(.title)
                            .bold()
                        Text("Followers")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                 
                    VStack{
                        Text(String(user?.following ?? 0))
                            .font(.title)
                            .bold()
                        Text("Following")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    }
                }
              
                VStack{
                    List{
                        ForEach(repository.repos , id: \.self){ repo in
                            Text(repo.name)
                            
                        }
                    }
                    .onAppear{
                        repository.fetch(userInputName: searchedText)
                    }
                    
                }
                
                
                Spacer()
            }
            else{
                ErrorView()
            }
        }
        .task{
            do{
                user  = try await getUser(userInputName: searchedText)
            }
            catch GHError.invalideURL{
                    print("Invalid URL")
                    isValid = false
            }
            catch GHError.invalideResponse{
                print("Invalid Response")
                isValid = false
            }
            catch GHError.invalidData{
                print("Invalid Data")
                isValid = false
            }
            catch{
                print("Unecpected Error")
                isValid = false
            }
        } //load the data before view appears
        .padding()
    }
    
}


struct ContentView_Previews: PreviewProvider {
    
    @State static var searchedText: String = ""
    
    static var previews: some View {
        ContentView(searchedText: $searchedText)
    }
}
