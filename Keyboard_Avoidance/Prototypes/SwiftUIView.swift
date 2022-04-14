//
//  SwiftUIView.swift
//  Keyboard_Avoidance
//
//  Created by Geri Borbás on 14/04/2022.
//  http://www.twitter.com/Geri_Borbas
//

import SwiftUI


struct SwiftUIView: View {
    
    @State var email: String = ""
    @State var givenName: String = ""
    @State var familyName: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            Text("Sign Up")
            Spacer()
            TextField("email", text: $email)
            TextField("given name", text: $givenName)
            TextField("family name", text: $familyName)
            TextField("password", text: $password)
        }
    }
}
