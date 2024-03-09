//
//  LoginView.swift
//  UniHelp
//
//  Created by Evan Best on 2024-03-09.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        NavigationView {
            VStack {
                // Image
                Image("study-pic")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 250)
                    .padding(.vertical, 32)

                // Form fields
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com")
                        .textInputAutocapitalization(.none)

                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your password",
                              isSecureField: true)
                }
                .padding(.horizontal)

                // Sign in button
                Button {
                    print("Log user in..")
                } label: {
                    HStack {
                        Text("SIGN IN")
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

                // Sign up button
                NavigationLink(
                    destination: RegistrationView()
                        .navigationBarBackButtonHidden(true))
                {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}


#Preview {
    LoginView()
}
