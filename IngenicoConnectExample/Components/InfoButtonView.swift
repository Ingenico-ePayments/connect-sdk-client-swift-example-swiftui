//
//  InfoButtonView.swift
//  IngenicoConnectExample
//
//  Created by Tihomir Videnov on 5.05.22.
//

import SwiftUI

struct InfoButtonView: View {

    // MARK: - Properties
    var buttonCallback: (() -> Void)?

    // MARK: - Body
    var body: some View {
        Image(systemName: "info.circle")
            .padding(.trailing, 20)
            .onTapGesture {
                if let buttonCallback = buttonCallback {
                    buttonCallback()
                }
            }
    }
}

// MARK: - Previews
#Preview {
    InfoButtonView()
}
