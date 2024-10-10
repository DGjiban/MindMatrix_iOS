//
//  RegisterView.swift
//  MindMatrix_iOS
//
//  Created by David Gilvan Dos Santos Souza on 2024-10-09.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    let db = Firestore.firestore()

    var body: some View {
    
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Register")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
                
                Spacer()
                
                TextField("Name", text: $name)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    // Register Function
                    registerUser()
                }) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.purple)
                        .cornerRadius(15.0)
                }.padding(20)
                
                // Cancel button
                Button(action: {
                    cancel()
                }) {
                    Text("Cancel")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.purple)
                        .cornerRadius(15.0)
                }
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Registration Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    func cancel(){
        presentationMode.wrappedValue.dismiss()
    }
    
    func registerUser(){
        // Check if the passwords match
        guard password == confirmPassword else {
            alertMessage = "Passwords do not match"
            showAlert = true
            return
        }
        
        // Verify the fields
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            alertMessage = "Please fill out all fields"
            showAlert = true
            return
        }
        
        // Create the user
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                alertMessage = "Error: \(error.localizedDescription)"
                showAlert = true
            } else {
                // If success save create the user in the database
                if let user = authResult?.user {
                    saveUserData(userID: user.uid)
                    cancel()
                }
            }
        }
    }
    
    // Create the user in database
    func saveUserData(userID: String) {
        let userData: [String: Any] = [
            "name": name,
            "email": email,
            "points": 0,
            "birth": ""
        ]

        // Save the user
        db.collection("users").document(userID).setData(userData) { error in
            if let error = error {
                alertMessage = "Error saving user data: \(error.localizedDescription)"
                showAlert = true
            } else {
                alertMessage = "User registered successfully!"
                showAlert = true
            }
        }
    }
}

