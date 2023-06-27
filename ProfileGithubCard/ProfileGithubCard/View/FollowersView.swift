//
//  FollowersView.swift
//  ProfileGithubCard
//
//  Created by Nick Theodoridis on 27/6/23.
//

import SwiftUI

struct URLImage: View{
    
    let urlString: String
    
    @State var data: Data?
    
    var body:some View{
        if let data = data,let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50,height: 50)
                .background(Color.gray)
                .clipShape(Circle())
        }
        else{
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50,height: 50)
                .background(Color.gray)
                .clipShape(Circle())
                .onAppear{
                    fetchData()
                }
        }
    }
    
    private func fetchData(){
        guard let url =  URL(string: urlString) else{
            return
        }
        
        let task =  URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data 
        }
        task.resume()
    }
}

struct FollowersView: View {
    
    @Binding var searchedText:String
    @StateObject var followers = FollowerModel()
    
    var body: some View {
            ScrollView(showsIndicators: false){
                    ForEach(followers.follower , id: \.self){ follower in
                        HStack{
                           Spacer()
                            URLImage(urlString: follower.avatar_url ?? "Image Placeholder")
                            Spacer()
                            Text(follower.login ?? "Name Placeholder")
                                .bold()
                                .frame(maxWidth: .infinity , alignment:.topLeading)
                                .padding()
                            Spacer()
                        }
                        .padding(.horizontal)
                }
                .onAppear{
                    followers.fetch(userInputName: searchedText)
                }
                .padding(.top)
            }
            .navigationTitle("Followers")
            
        
    }
}

struct FollowersView_Previews: PreviewProvider {
    @State static var searchedText: String = ""
    static var previews: some View {
        FollowersView(searchedText: $searchedText)
    }
}
