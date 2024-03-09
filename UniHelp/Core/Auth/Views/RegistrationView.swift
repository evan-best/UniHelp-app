//
//  RegistrationView.swift
//  UniHelp
//
//  Created by Evan Best on 2024-03-09.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        // Image
        Image("study-pic")
            .resizable()
            .scaledToFill()
            .frame(width: 150, height: 250)
            .padding(.vertical, 32)
        
        // Form fields
        
        VStack(spacing: 24) {
            
            InputView(text: $fullname,
                      title: "Full Name",
                      placeholder: "Enter your name")
            
            InputView(text: $email,
                      title: "Email Address",
                      placeholder: "name@example.com")
            .textInputAutocapitalization(.none)
            
            InputView(text: $password,
                      title: "Password",
                      placeholder: "Enter your password",
                      isSecureField: true)
            
            InputView(text: $confirmPassword,
                      title: "Confirm Password",
                      placeholder: "Confirm your password")
        }
        .padding(.horizontal)
        .padding(.top, 12)
        
        // Sign up button
        
        Button {
            Task {
                try await viewModel.createUser(withEmail:email,
                                                password: password,
                                                fullname: fullname)
            }
        } label: {
            HStack {
                Text("SIGN UP")
                    .fontWeight(.semibold)
                Image(systemName: "arrow.right")
            }
            .foregroundStyle(Color.white)
            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
        }
        .background(Color(.systemPurple))
        .cornerRadius(10)
        .padding(.top, 24)
        
        Spacer()
        
        Button {
            dismiss()
        } label: {
            HStack(spacing: 3) {
                Text("Already have an account?")
                Text("Sign in")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
            }
            .font(.system(size: 14))
        }
    }
}

#Preview {
    RegistrationView()
}
