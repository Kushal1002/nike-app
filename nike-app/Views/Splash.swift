//
//  Splash.swift
//  nike-app
//
//  Created by kushal  on 30/06/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct Splash: View {
    
    @State var isActive = false
    
    var body: some View {
        VStack {
            if isActive {
                // here if user is nil means user not signed in to the app then they will move to Onboarding otherwise direct to contentview 
                if Auth.auth().currentUser != nil {
                    ContentView()
                } else {
                    Onboarding()
                }
            } else {
                Text("NIKE")
                    .font(.largeTitle.bold())
            }
        }
        .onAppear() {
            // We move to onboarding screen after 2.5 secs
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation{
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    Splash()
}
