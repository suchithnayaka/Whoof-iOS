//
//  KeyPadButton.swift
//  Whoof
//
//  Created by Suchith Nayaka on 11/06/22.
//

import Foundation
import SwiftUI

struct KeyPadButton: View {
    var key: String
    
    var body: some View {
        Button {
            self.action(self.key)
            
        } label: {
            ZStack {
                Circle()
                    .fill(Color(hex: "#9599B3"))
                    .opacity(0.2)
                    .frame(width: 100, height: 100)
                Text(key)
                    .foregroundColor(.white)
                    .fontWeight(.light)
                    .font(.system(size: 36))
                    .padding()
            }
        }
    }
    
    enum ActionKey: EnvironmentKey {
        static var defaultValue: (String) -> Void { { _ in } }
    }
    
    @Environment(\.keyPadButtonAction) var action: (String) -> Void
}

extension EnvironmentValues {
    var keyPadButtonAction: (String) -> Void {
        get { self[KeyPadButton.ActionKey.self] }
        set { self[KeyPadButton.ActionKey.self] = newValue }
    }
}
