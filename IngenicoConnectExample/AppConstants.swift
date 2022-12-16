//
//  AppConstants.swift
//  IngenicoConnectExample
//
//  Copyright © 2022 Global Collect Services. All rights reserved.
//

import Foundation
import UIKit
import IngenicoConnectKit

public class AppConstants {
    static let sdkBundle = Bundle(path: SDKConstants.kSDKBundlePath!)!
    public static var appBundle = Bundle.main
    static let AppLocalizable = "AppLocalizable"
    static let ApplicationIdentifier = "SwiftUI Example Application/v1.0.0"
    static let ClientSessionId = "ClientSessionId"
    static let CustomerId = "CustomerId"
    static let MerchantId = "MerchantId"
    static let BaseURL = "BaseURL"
    static let AssetsBaseURL = "AssetsBaseURL"
    static let Price = "Price"
    static let Currency = "Currency"
    static let GroupProducts = "GroupProducts"
    static let ApplePay = "ApplePay"
    static let CountryCode = "CountryCode"
    static let CreditCardField = "cardNumber"
    static let CVVField = "cvv"
    static let ExpiryDateField = "expiryDate"
    static let CardHolderField = "cardholderName"
}
