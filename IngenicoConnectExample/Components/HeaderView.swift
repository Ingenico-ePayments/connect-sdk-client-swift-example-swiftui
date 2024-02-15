//
//  HeaderView.swift
//  IngenicoConnectExample
//
//  Copyright © 2022 Global Collect Services. All rights reserved.
//

import SwiftUI

struct HeaderView: View {

    // MARK: - Body
    var body: some View {
        VStack(spacing: 10) {
            Image("logo_merchant")
                .resizable()
                .scaledToFit()
                .padding(.top, 40)
                .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.15)
            HStack {
                Spacer()
                HStack {
                    Image("SecurePaymentIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                    Text("Secure payment")
                        .font(.subheadline)
                        .foregroundColor(.green)
                }
            }
        }.padding(.horizontal, 20)
    }
}

// MARK: - Previews
#Preview {
    HeaderView()
}
