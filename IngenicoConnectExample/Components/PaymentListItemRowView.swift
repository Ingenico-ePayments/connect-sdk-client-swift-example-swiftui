//
//  PaymentListItemCellView.swift
//  IngenicoConnectExample
//
//  Created by Tihomir Videnov on 5.05.22.
//

import SwiftUI

struct PaymentListItemRowView: View {
    var image: UIImage
    var text: String

    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(12)
            PaymentListItemView(image: image, text: text)
        }
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

struct PaymentListItemCellView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ForEach(0...5, id: \.self ) { _ in
                PaymentListItemRowView(image: UIImage(), text: "Example text")
            }
        }

    }
}
