//
//  EndScreenViewModel.swift
//  IngenicoConnectExample
//
//  Copyright © 2022 Global Collect Services. All rights reserved.
//

import Foundation
import IngenicoConnectKit
import MobileCoreServices

extension EndScreen {

    class ViewModel: ObservableObject {

        @Published var showEnryptedFields: Bool = false

        var preparedPaymentRequest: PreparedPaymentRequest?

        init(preparedPaymentRequest: PreparedPaymentRequest?) {
            self.preparedPaymentRequest = preparedPaymentRequest
        }

        func copyToClipboard() {
            UIPasteboard.general.string = self.preparedPaymentRequest?.encryptedFields ?? ""
        }

        func returnToStart() {
            NavigationUtil.popToRootView()
        }

    }
}
