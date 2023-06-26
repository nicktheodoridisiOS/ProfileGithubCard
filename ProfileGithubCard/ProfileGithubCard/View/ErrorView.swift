//
//  ErrorView.swift
//  ProfileGithubCard
//
//  Created by Nick Theodoridis on 6/6/23.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        Text("No User Found")
            .font(.title)
            .foregroundColor(.accentColor)
            .bold()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView()
    }
}
