//
//  TabGroubView.swift
//  ProfileGithubCard
//
//  Created by Nick Theodoridis on 27/6/23.
//

import SwiftUI

struct TabControllerView: View {
    var body: some View {
        TabView{
            SearchView()
                .tabItem(){
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
        }
    }
}

struct TabControllerView_Previews: PreviewProvider {
    static var previews: some View {
        TabControllerView()
    }
}
