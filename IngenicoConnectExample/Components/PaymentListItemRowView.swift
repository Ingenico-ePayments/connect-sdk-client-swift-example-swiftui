//
//  PaymentListItemCellView.swift
//  IngenicoConnectExample
//
//  Created by Tihomir Videnov on 5.05.22.
//

import SwiftUI

struct PaymentListItemRowView: View {
    // MARK: - Properties
    var image: UIImage
    var text: String

    // MARK: - Body
    var body: some View {
        ZStack {
            Color.white
                .cornerRadius(12)
            PaymentListItemView(image: image, text: text)
        }
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Previews
#Preview {
    List {
        ForEach(0...5, id: \.self ) { _ in
            PaymentListItemRowView(image: UIImage(), text: "Example text")
        }
    }
}
