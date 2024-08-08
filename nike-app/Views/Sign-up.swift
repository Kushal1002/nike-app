//
//  Sign-up.swift
//  nike-app
//
//  Created by kushal  on 01/07/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

struct Sign_up: View {
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var isLoading = false
    
    @Environment(\.presentationMode) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 40, content: {
                Image(systemName: "arrow.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss.wrappedValue.dismiss()
                    }
                
                VStack(alignment: .leading, spacing: 15, content: {
                    Text("Sign-up")
                        .font(.title)
                    
                    Text("Enter your name, email address and password to sign up.")
                        .font(.callout)
                })
                
                VStack(spacing: 15, content: {
                    
                    TextField("User name", text: $email)
                        .padding(.horizontal)
                        .frame(height: 60)
                        .background(.gray.opacity(0.2))
                        .clipShape(Capsule())
                        .overlay {
                            Capsule()
                                .stroke(.gray.opacity(0.8), lineWidth: 0.5)
                        }
                    
                    TextField("Email Address", text: $username)
                        .padding(.horizontal)
                        .frame(height: 60)
                        .background(.gray.opacity(0.2))
                        .clipShape(Capsule())
                        .overlay {
                            Capsule()
                                .stroke(.gray.opacity(0.8), lineWidth: 0.5)
                        }
                    
                    SecureField("Password", text: $password)
                        .padding(.horizontal)
                        .frame(height: 60)
                        .background(.gray.opacity(0.2))
                        .clipShape(Capsule())
                        .overlay {
                            Capsule()
                                .stroke(.gray.opacity(0.8), lineWidth: 0.5)
                        }
                })
                
                Spacer()
                
                // Login Button
                VStack(spacing: 15, content: {
                    Button {
                        //signup
                        Auth.auth().createUser(withEmail: email, password: password) {(result, error) in
                            
                            if error != nil {
                                print(error?.localizedDescription ?? "")
                                withAnimation {
                                    isLoading.toggle()
                                }
                            } else {
                                // now we store user basic details to firebase database
                                let db = Firestore.firestore()
                                let data: [String: Any] = [
                                    "User Name": username,
                                    "Email": email,
                                ]
                                
                                // now we add same user name and email to local memory so we don't need to sync every time
                                UserDefaults.standard.setValue(result?.user.uid, forKey: "UID")
                                // UID is unique key provided to user when they signup to firestore database
                                
                                UserDefaults.standard.setValue(username, forKey: "NAME")
                                UserDefaults.standard.setValue(email, forKey: "EMAIL")
                                
                                db.collection("USERS").addDocument(data: data)
                                isLoading.toggle()
                            }
                        }
                    } label: {
                        if isLoading {
                            ProgressView()
                        } else {
                            Text("Continue")
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.black)
                    .clipShape(Capsule())
                    .foregroundColor(.white)
                    
                    NavigationLink {
                        Sign_in()
                    } label: {
                        Text("Already have an account? **Sign-in**")
                            .frame(maxWidth: .infinity)
                    }
                    .foregroundColor(.black)
                })
            })
            .padding()
//            .preferredColorScheme(.dark)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    Sign_up()
}
