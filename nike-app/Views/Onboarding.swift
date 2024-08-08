//
//  Onboarding.swift
//  nike-app
//
//  Created by kushal  on 30/06/24.
//

import SwiftUI

struct Onboarding: View {
    
    @State private var isActive = false
    // Now add some animation properties
    @State private var isExpanded = false
    @State private var offset = CGSize.zero
    
    var body: some View {
        if isActive {
            // We move to login screen after that
            Sign_in()
        } else {
            //Design of this view
            
            ZStack(alignment: .top) {
                VStack {
                    Spacer()
                    // Add a red circle in bottom that show animation
                    Circle()
                        .fill(
                            RadialGradient(colors: [.white, .clear, .clear, .clear], center: .center, startRadius: 0, endRadius: UIScreen.main.bounds.width)
                        )
                        .scaleEffect(isExpanded ? 20 : 3)
                        .padding(.bottom, -(UIScreen.main.bounds.width / 2))
                }
                .frame(height: .infinity)
                .zIndex(isExpanded ? 2 : 0)
                
                VStack(spacing: 15, content: {
                    Spacer()
                    
                    Image("shoes-onboarding6")
                        .resizable()
                        .scaledToFit()
                    
                    Text("Start Journey\nwith NIKE")
                        .font(.largeTitle.bold())
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    
                    Text("Smart gorgeous and fashionable collection makes you cool")
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .opacity(0.6)
                    
                    Spacer()
                    
                    VStack {
                        Image(systemName: "chevron.up")
                        
                        Text("Get Started")
                            .padding(.top)
                    }
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                })
                .opacity(isExpanded ? 0 : 1)
                .offset(offset)
            }
            
            // When user swipe up all layout goes up so for that swipe up gesture
            .gesture(DragGesture()
                .onEnded({ value in
                    if value.translation.height < 50 {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            offset = value.translation
                            isExpanded = true
                        }
                        
                        // Now when swiped up we move to next screen
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            withAnimation{
                                isActive.toggle()
                            }
                        }
                    }
                }))
            .padding()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(
                Image("shoes-onboarding9")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}


#Preview {
    Onboarding()
}
