//
//  MainScreenView.swift
//  MindMatrix_iOS
//
//  Created by David Gilvan Dos Santos Souza on 2024-10-09.
//

import SwiftUI

struct MainScreenView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            RankingView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Ranking")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
            }
    }
}

#Preview {
    MainScreenView()
}
