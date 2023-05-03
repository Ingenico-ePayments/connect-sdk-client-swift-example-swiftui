//
//  InfoButtonView.swift
//  IngenicoConnectExample
//
//  Created by Tihomir Videnov on 5.05.22.
//

import SwiftUI

struct InfoButtonView: View {
    var buttonCallback: (() -> Void)?

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

struct InfoButtonView_Previews: PreviewProvider {
    static var previews: some View {
        InfoButtonView()
    }
}
