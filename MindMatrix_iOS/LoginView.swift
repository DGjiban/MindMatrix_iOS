//
//  LoginView.swift
//  MindMatrix_iOS
//
//  Created by David Gilvan Dos Santos Souza on 2024-10-09.
//
import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
        
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
            
                VStack {
                    Text("MindMatrix")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    Spacer()
                    
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
                    
                    NavigationLink(destination: forgetPasswordView()) {
                        Text("Forget password")
                            .padding(5)
                            .foregroundColor(.cyan)
                            .font(.headline)
                    }.padding()

                    Button(action: {
                        login()
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.purple)
                            .cornerRadius(15.0)
                    }

                    NavigationLink(destination: RegisterView()) {
                        Text("Register")
                            .padding(10)
                            .background(Color.white)
                            .foregroundColor(.purple)
                            .cornerRadius(10)
                            .font(.headline)
                    }
                    .padding(.top, 20)
                    
                    Spacer()

                    Text("@2024 MindMatrix")
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                }
                .padding(40)
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Notification"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // Function to Login
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                alertMessage = "Error signing in: \(error.localizedDescription)"
                showAlert = true
            } else {
                alertMessage = "Welcome to MindMatrix"
                showAlert = true
                isLoggedIn = true
            }
        }
    }
}
