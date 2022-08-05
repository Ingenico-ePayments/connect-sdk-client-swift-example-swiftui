//
//  PaymentListItemView.swift
//  IngenicoConnectExample
//
//  Copyright © 2022 Global Collect Services. All rights reserved.
//

import SwiftUI

struct PaymentListItemView: View {
    var image: UIImage
    var text: String
    
    var body: some View {
        HStack(spacing: 20) {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            Text(text)
            Spacer()
        }
        .padding(.leading, 15)
        .padding(10)
    }
}

// MARK: - Previews
struct PaymentListItemView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentListItemView(image: UIImage(named: "MerchantLogo")!, text: "Example text")
            .previewLayout(.sizeThatFits)
    }
}
