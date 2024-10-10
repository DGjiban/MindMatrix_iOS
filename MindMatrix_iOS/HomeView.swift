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
    @State var quizzes: Int = 0
    @State var userPoints: String = ""
    @State var showAlert = false
    @State var alertMessage = ""
    @State var isLoggedOut = false //Control the logout
    
    let db = Firestore.firestore()

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    Text("Welcome, \(userName)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 50)
                    
                    Text("Points: \(userPoints)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Text("Current challenge: \(quizzes)")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    // Quiz button
                    NavigationLink(destination: GamingView()) {
                        Text("Start Quiz")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 250, height: 60)
                            .background(Color.purple)
                            .cornerRadius(15.0)
                    }
                    
                    Spacer()
                    
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
                    fetchQuizCount()
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .fullScreenCover(isPresented: $isLoggedOut) {
                    // send to login page when is not logged
                    LoginView(isLoggedIn: .constant(false))
                }
            }
        }
    }

    // Fetch user
    func fetchUserData() {
        guard let currentUser = Auth.auth().currentUser, let email = currentUser.email else {
            alertMessage = "No logged user"
            showAlert = true
            return
        }

        db.collection("users").whereField("email", isEqualTo: email).getDocuments { (querySnapshot, error) in
            if let error = error {
                alertMessage = "Error fetching user data: \(error.localizedDescription)"
                showAlert = true
            } else if let documents = querySnapshot?.documents, !documents.isEmpty {
                if let document = documents.first {
                    self.userName = document.get("name") as? String ?? "Unknown"
                    self.userPoints = document.get("points") as? String ?? ""
                }
            } else {
                alertMessage = "No user found with this email"
                showAlert = true
            }
        }
    }

    // Fetch the number of quizzes
    func fetchQuizCount() {
        db.collection("quizzes").getDocuments { (querySnapshot, error) in
            if let error = error {
                alertMessage = "Error fetching quizzes count: \(error.localizedDescription)"
                showAlert = true
            } else {
                self.quizzes = querySnapshot?.documents.count ?? 0
            }
        }
    }
    
    // Function to logout
    func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedOut = true // Set to true to redirect to login view
        } catch let signOutError as NSError {
            alertMessage = "Error signing out: \(signOutError.localizedDescription)"
            showAlert = true
        }
    }
}
