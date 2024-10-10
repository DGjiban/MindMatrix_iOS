//
//  ContentView.swift
//  MindMatrix_iOS
//
//  Created by David Gilvan Dos Santos Souza on 2024-10-09.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State private var isLoggedIn = false

    var body: some View {
        Group {
            if isLoggedIn {
                MainScreenView()
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
        .onAppear {
            checkLoginStatus()
        }
    }

    // Check if the user is logged
    func checkLoginStatus() {
        // Start FirebaseAuth
        if Auth.auth().currentUser != nil {
            // O usuário está autenticado
            isLoggedIn = true
        } else {
            // O usuário não está autenticado
            isLoggedIn = false
        }
    }
}

#Preview {
    ContentView()
}
