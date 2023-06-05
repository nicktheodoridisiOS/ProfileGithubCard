//
//  ContentView.swift
//  ProfileGithubCard
//
//  Created by Nick Theodoridis on 5/6/23.
//

import SwiftUI

struct ContentView: View {
    
    @State  private var user: User?
    @State  private var repo: Repository?
    
    
    
    var body: some View {
        VStack (spacing: 20){
            
            
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
          
            
            
            
            Spacer()
        }
        .padding()
        .task{
            do{
                user  = try await getUser()
                //repo =  try await getRepo()
            }
            catch GHError.invalideURL{
                    print("Invalid URL")
            }
            catch GHError.invalideResponse{
                print("Invalid Response")
            }
            catch GHError.invalidData{
                print("Invalid Data")
            }
            catch{
                print("Unecpected Error")
            }
        } //load the data before view appears
    }
    
}


struct Divider: View {
    
    var body: some View {
        Rectangle()
            .frame(width: 1,height: 30)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
