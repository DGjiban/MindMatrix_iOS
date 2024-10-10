//
//  HomeView.swift
//  MindMatrix_iOS
//
//  Created by David Gilvan Dos Santos Souza on 2024-10-09.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct HomeView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var userName: String = ""
    @State var quizzes: String = ""
    @State var userPoints: Int = 0
    @State var showAlert = false
    @State var alertMessage = ""
    
    let db = Firestore.firestore()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome, \(userName)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)

                Text("Points: \(userPoints)")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(.top, 10)
                
                Text("Current challenge: \(quizzes)")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(.top, 10)

                Spacer()

                // Quiz button
                NavigationLink(destination: GamingView()) {
                    Text("Start Quiz")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 250, height: 60)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }

                // Logout button
                Button(action: {
                    logout()
                }) {
                    Text("Logout")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 250, height: 60)
                        .background(Color.red)
                        .cornerRadius(15.0)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Home")
            .onAppear {
                fetchUserData()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    // Fetchuser
    func fetchUserData() {
        guard let currentUser = Auth.auth().currentUser else {
            alertMessage = "No logged user"
            showAlert = true
            return
        }

        let userID = currentUser.uid

        db.collection("users").document(userID).getDocument { document, error in
            if let document = document, document.exists {
                self.userName = document.get("name") as? String ?? "Unknown"
                self.userPoints = document.get("points") as? Int ?? 0
            } else {
                alertMessage = "Error fetching user data"
                showAlert = true
            }
        }
    }

    // Function to logout
    func logout() {
        do {
            try Auth.auth().signOut()
            alertMessage = "You have been logged out"
            showAlert = true
            
        } catch let signOutError as NSError {
            alertMessage = "Error signing out: \(signOutError.localizedDescription)"
            showAlert = true
        }
    }
}
