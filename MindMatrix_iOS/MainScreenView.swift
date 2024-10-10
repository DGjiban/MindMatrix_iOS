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
            NavigationView {
                HomeView()
                    .navigationBarTitle("Home", displayMode: .inline)
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }

            NavigationView {
                RankingView()
                    .navigationBarTitle("Ranking", displayMode: .inline)
            }
            .tabItem {
                Image(systemName: "star.fill")
                Text("Ranking")
            }

            NavigationView {
                ProfileView()
                    .navigationBarTitle("Profile", displayMode: .inline)
            }
            .tabItem {
                Image(systemName: "person.fill")
                Text("Profile")
            }
        }
        .accentColor(.white)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.clear
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        
        }
    }
}

#Preview {
    MainScreenView()
}
