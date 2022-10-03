//
//  WelcomeView.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 30. 9. 2022..
//

import SwiftUI

struct WelcomeView: View {
    @State var currentTab: Int = 0
    var body: some View {
        VStack {
            Text(LocalizedStringKey("welcomeScreen_title"))
                .font(.system(size: 32))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .lineLimit(3)
            Text(LocalizedStringKey("welcomeScreen_text"))
            .font(.body)
            .fontWeight(.regular)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .center)
            Button {
                
            } label: {
                Text(LocalizedStringKey("welcome_btn"))
                    .foregroundColor(.blue)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .frame(maxWidth: 350, maxHeight: 46)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.white)
                    )

            }
        }
        .frame(maxWidth: 350)
    }
}
