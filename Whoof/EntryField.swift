//
//  EntryField.swift
//  Whoof
//
//  Created by Suchith Nayaka on 11/06/22.
//

import Foundation
import SwiftUI

struct EntryField: View {
    var placeHolder: String
    var prompt: String
    @Binding var field: String
    var isSecure:Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if isSecure {
                    SecureField("", text: $field)
                        .autocapitalization(.none)
                        .foregroundColor(.black)
                        .placeholder(when: field.isEmpty) {
                            Text(placeHolder)
                                .foregroundColor(.black)
                                .opacity(0.2)
                        }
                } else {
                    TextField("", text: $field)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .foregroundColor(.black)
                        .placeholder(when: field.isEmpty) {
                            Text(placeHolder)
                                .foregroundColor(.black)
                                .opacity(0.2)
                        }
                }
            }
            .padding(16)
            .background(Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .padding(.vertical, 8)
    }
}
