//
//  forgetPasswordView.swift
//  MindMatrix_iOS
//
//  Created by David Gilvan Dos Santos Souza on 2024-10-09.
//

import SwiftUI
import FirebaseAuth

struct forgetPasswordView: View {
            
    @State var email: String = ""
    @State var showAlert = false
    @State var alertMessage = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.indigo, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("Forgot Password")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 40)
                
                Spacer()
                
                TextField("Enter your email", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(5)
                    .padding(.bottom, 20)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    resetPassword()
                }) {
                    Text("Reset Password")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.purple)
                        .cornerRadius(15.0)
                }
                .padding(.top, 20)
                
                Spacer()

                Text("@2024 MindMatrix")
                    .foregroundColor(.white)
                    .padding(.bottom, 5)
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Notification"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    // Function to reset password
    func resetPassword() {
        guard !email.isEmpty else {
            alertMessage = "Please enter your email address."
            showAlert = true
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                alertMessage = "Error: \(error.localizedDescription)"
                showAlert = true
            } else {
                alertMessage = "A password reset email has been sent to \(email)"
                showAlert = true
            }
        }
    }
}

#Preview {
    forgetPasswordView()
}
