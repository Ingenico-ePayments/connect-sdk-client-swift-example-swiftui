//
//  InitialScreenViewModel.swift
//  IngenicoConnectExample
//
//  Copyright © 2022 Global Collect Services. All rights reserved.
//

import Foundation
import IngenicoConnectKit
import UIKit

extension StartScreen {
    class ViewModel: ObservableObject {
        
        // MARK: - Properties
        
        @Published var clientSessionId: String = ""
        @Published var clientSessionIdError: String? = nil
        
        @Published var customerID: String = ""
        @Published var customerIDError: String? = nil
        
        @Published var clientApiUrl: String = ""
        @Published var clientApiUrlError: String? = nil
        
        @Published var assetsUrl: String = ""
        @Published var assetsUrlError: String? = nil
        
        @Published var amount: String = ""
        @Published var amountError: String? = nil
        
        @Published var countryCode: String = ""
        @Published var countryCodeError: String? = nil
        
        @Published var currencyCode: String = ""
        @Published var currencyCodeError: String? = nil
        
        @Published var merchantId: String = ""
        @Published var merchantIdError: String? = nil
        
        @Published var recurringPayment: Bool = false
        @Published var groupProducts: Bool = false
        @Published var applePay: Bool = false
        
        @Published var errorMessage: String?
        @Published var showAlert: Bool = false
        @Published var infoText: String = ""
        @Published var showPaymentList: Bool = false
        @Published var isLoading: Bool = false
        
        let emptyFieldError = "EmptyField".localized
        
        var session: Session?
        var context: PaymentContext?
        var paymentItems: PaymentItems?
        
        init() {
            clientSessionId = UserDefaults.standard.string(forKey: AppConstants.ClientSessionId) ?? ""
            customerID = UserDefaults.standard.string(forKey: AppConstants.CustomerId) ?? ""
            clientApiUrl = UserDefaults.standard.string(forKey: AppConstants.BaseURL) ?? ""
            assetsUrl = UserDefaults.standard.string(forKey: AppConstants.AssetsBaseURL) ?? ""
            
            amount = UserDefaults.standard.string(forKey: AppConstants.Price) ?? ""
            countryCode = UserDefaults.standard.string(forKey: AppConstants.CountryCode) ?? ""
            currencyCode = UserDefaults.standard.string(forKey: AppConstants.Currency) ?? ""
            merchantId = UserDefaults.standard.string(forKey: AppConstants.MerchantId) ?? ""
            
            groupProducts = UserDefaults.standard.bool(forKey: AppConstants.GroupProducts)
            applePay = UserDefaults.standard.bool(forKey: AppConstants.ApplePay)
            
        }
        
        // MARK: - Actions
        func proceedToCheckout() {
            isLoading = true
            
            validateClientSessionId()
            validateCustomerID()
            validateClientApiUrl()
            validateAssetsUrl()
            validateAmount()
            validateCountryCode()
            validateCurrencyCode()
            
            guard clientSessionIdError == nil &&
                customerIDError == nil &&
                clientApiUrlError == nil &&
                assetsUrlError == nil &&
                amountError == nil &&
                countryCodeError == nil &&
                currencyCodeError == nil else {
                isLoading = false
                return
            }
            
            session = Session(clientSessionId: clientSessionId,
                              customerId: customerID,
                              baseURL: clientApiUrl,
                              assetBaseURL: assetsUrl,
                              appIdentifier: "SwiftUI Example Application")
            
            UserDefaults.standard.set(clientSessionId, forKey: AppConstants.ClientSessionId)
            UserDefaults.standard.set(customerID, forKey: AppConstants.CustomerId)
            UserDefaults.standard.set(clientApiUrl, forKey: AppConstants.BaseURL)
            UserDefaults.standard.set(assetsUrl, forKey: AppConstants.AssetsBaseURL)
            
            UserDefaults.standard.set(amount, forKey: AppConstants.Price)
            UserDefaults.standard.set(countryCode, forKey: AppConstants.CountryCode)
            UserDefaults.standard.set(currencyCode, forKey: AppConstants.Currency)
            UserDefaults.standard.set(merchantId, forKey: AppConstants.MerchantId)
            
            UserDefaults.standard.set(groupProducts, forKey: AppConstants.GroupProducts)
            UserDefaults.standard.set(applePay, forKey: AppConstants.ApplePay)
            
            let amountOfMoney = PaymentAmountOfMoney(totalAmount: Int(amount) ?? 0, currencyCode: currencyCode)
            context = PaymentContext(amountOfMoney: amountOfMoney, isRecurring: recurringPayment, countryCode: countryCode)
            guard let context = context else {
                Macros.DLog(message: "Could not find context")
                self.showAlert(text: "Could not retrieve payment items. Please try again later.")
                self.isLoading = false
                return
            }
                        
            session?.paymentItems(for: context, groupPaymentProducts: groupProducts, success: { paymentItems in
                self.isLoading = false
                self.paymentItems = paymentItems
                self.showPaymentList = true
            }, failure: { error in
                self.showAlert(text: error.localizedDescription)
                self.isLoading = false
            })
        }
        
        
        func pasteFromJson() {
            if let value = UIPasteboard.general.string {
                guard let result = parseJson(value) else {
                    showAlert(text:"JsonErrorMessage".localized)
                    return
                }
                clientSessionId = result.clientId ?? ""
                customerID = result.customerId ?? ""
                clientApiUrl = result.baseUrl ?? ""
                assetsUrl = result.assetUrl ?? ""
            }
        }
        
        // MARK: - Helpers
        private func parseJson(_ jsonString: String) -> ClientSessionParsedJsonData? {
            guard let data = jsonString.data(using: .utf8) else {
                showAlert(text:"data is nil")
                return nil
            }
            do {
                return try JSONDecoder().decode(ClientSessionParsedJsonData.self, from: data)
            } catch {
                showAlert(text:"JsonErrorMessage".localized)
                return nil
            }
        }
        
        private func showAlert(text: String) {
            errorMessage = text
            showAlert = true
        }
        
        func prepareItems(paymentItems: PaymentItems?) -> [PaymentProductsRow] {
            var items: [PaymentProductsRow] = []
            guard let paymentItems = paymentItems else { return items }
            for paymentItem in paymentItems.paymentItems.sorted(by: { a, b in
                return a.displayHints.displayOrder ?? Int.max < b.displayHints.displayOrder ?? Int.max
            }) {
                let paymentProductKey = localizationKey(with: paymentItem)
                let paymentProductValue = NSLocalizedString(paymentProductKey, tableName: SDKConstants.kSDKLocalizable, bundle: AppConstants.sdkBundle, value: "", comment: "")
                let row = PaymentProductsRow(name: paymentProductValue,
                                             accountOnFileIdentifier: "",
                                             paymentProductIdentifier: paymentItem.identifier,
                                             logo: paymentItem.displayHints.logoImage ?? UIImage())
                items.append(row)
                
            }
            return items
        }
        
        private func localizationKey(with paymentItem: BasicPaymentItem) -> String {
            switch paymentItem {
            case is BasicPaymentProduct:
                return "gc.general.paymentProducts.\(paymentItem.identifier).name"
                
            case is BasicPaymentProductGroup:
                return "gc.general.paymentProductGroups.\(paymentItem.identifier).name"
                
            default:
                return ""
            }
        }
        
        // MARK: - Field Validation
        
        private func validateClientSessionId() {
            if clientSessionId == "" {
                clientSessionIdError = emptyFieldError
            } else {
                clientSessionIdError = nil
            }
        }
        
        private func validateCustomerID() {
            if customerID == "" {
                customerIDError = emptyFieldError
            } else {
                customerIDError = nil
            }
        }
        
        private func validateClientApiUrl() {
            if clientApiUrl == "" {
                clientApiUrlError = emptyFieldError
            } else {
                clientApiUrlError = nil
            }
        }
        
        private func validateAssetsUrl() {
            if assetsUrl == "" {
                assetsUrlError = emptyFieldError
            } else {
                assetsUrlError = nil
            }
        }
        
        private func validateAmount() {
            if amount == "" {
                amountError = emptyFieldError
            } else {
                amountError = nil
            }
        }
        
        private func validateCountryCode() {
            if countryCode == "" {
                countryCodeError = emptyFieldError
            } else {
                countryCodeError = nil
            }
        }
        
        private func validateCurrencyCode() {
            if currencyCode == "" {
                currencyCodeError = emptyFieldError
            } else {
                currencyCodeError = nil
            }
        }
    }
}
