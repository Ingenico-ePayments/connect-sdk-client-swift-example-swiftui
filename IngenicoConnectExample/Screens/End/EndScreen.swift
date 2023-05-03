//
//  EndScreen.swift
//  IngenicoConnectExample
//
//  Copyright © 2022 Global Collect Services. All rights reserved.
//

import IngenicoConnectKit
import SwiftUI

struct EndScreen: View {

    @ObservedObject var viewModel: ViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Text("SuccessLabel".localized)
                    .font(.largeTitle)
                Text("SuccessText".localized)
                    .font(.headline)
                Button(
                    viewModel.showEnryptedFields ?
                    "EncryptedDataResultShow".localized :
                    "EncryptedDataResultShow".localized
                ) {
                    viewModel.showEnryptedFields.toggle()
                }

                if viewModel.showEnryptedFields {
                    Text(viewModel.preparedPaymentRequest?.encryptedFields ?? "")
                    Text(viewModel.preparedPaymentRequest?.encodedClientMetaInfo ?? "")
                }

                Button(action: {
                    viewModel.copyToClipboard()
                }, label: {
                    Text("CopyEncryptedDataLabel".localized)
                        .foregroundColor(.green)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.green, lineWidth: 2)
                        )
                })

                Button(action: {
                    viewModel.returnToStart()
                }, label: {
                    Text("ReturnToStart".localized)
                        .foregroundColor(.red)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.red, lineWidth: 2)
                        )
                })
            }
            .padding()
        }
    }
}

struct EndScreen_Previews: PreviewProvider {
    static var previews: some View {
        EndScreen(viewModel: EndScreen.ViewModel(preparedPaymentRequest: nil))
    }
}
