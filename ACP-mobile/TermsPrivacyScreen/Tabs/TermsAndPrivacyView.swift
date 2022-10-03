//
//  TermsAndPrivacyView.swift
//  ACP-mobile
//
//  Created by Eldar Tutnjic on 30. 9. 2022..
//

import SwiftUI

struct TermsAndPrivacyView: View {
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(LocalizedStringKey("terms_title"))
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .lineLimit(2)
                    Spacer()
                }
                Text(LocalizedStringKey("terms_text"))
                .font(.body)
                .fontWeight(.regular)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                HStack {
                    Text(LocalizedStringKey("privacy_title"))
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .lineLimit(3)
                    Spacer()
                }
                Text(LocalizedStringKey("privacy_text"))
                .font(.body)
                .fontWeight(.regular)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
                Button {
                    
                } label: {
                    Text(LocalizedStringKey("termsPrivacy_btn"))
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(maxWidth: 350, maxHeight: 46)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.blue)
                        )
                }
            }
            .frame(maxWidth: 350)
        }
    }
}
