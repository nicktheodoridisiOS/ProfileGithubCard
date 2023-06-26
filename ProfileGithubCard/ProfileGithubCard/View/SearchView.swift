//
//  SearchView.swift
//  ProfileGithubCard
//
//  Created by Nick Theodoridis on 6/6/23.
//

import SwiftUI

struct SearchView: View {
    
    @State var textFieldText: String = ""
    
    var body: some View {
        NavigationView{
            VStack(spacing: 15){
                TextField("@mygithubaccount",text: $textFieldText)
                    .padding()
                    .background(Color.gray.opacity(0.3).cornerRadius(10))
                    .autocorrectionDisabled(true)
                
                NavigationLink("Search", destination: ContentView(searchedText: $textFieldText))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity , maxHeight: 50)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.accentColor)
                    }
                
            
                Spacer()
            }
            .padding()
            .navigationTitle("Github Account")
            
        }
        
    }
    
    struct SearchView_Previews: PreviewProvider {
        static var previews: some View {
            SearchView()
        }
    }
}
