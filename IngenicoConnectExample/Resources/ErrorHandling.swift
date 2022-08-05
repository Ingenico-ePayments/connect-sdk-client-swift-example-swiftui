//
//  ErrorHandling.swift
//  IngenicoConnectExample
//
//  Copyright © 2022 Global Collect Services. All rights reserved.
//

import Foundation
import IngenicoConnectKit

struct ErrorHandler {
    static func error(withIINDetails iinDetailsResponse: IINDetailsResponse) -> ValidationError? {
        if iinDetailsResponse.status == IINStatus.existingButNotAllowed {
            return ValidationErrorAllowed()
        }
        else if iinDetailsResponse.status == IINStatus.unknown {
            return ValidationErrorLuhn()
        }
        return nil
    }
    
    static func errorMessage(for error: ValidationError, withCurrency: Bool) -> String {
        let errorClass = error.self
        let errorMessageFormat = "gc.general.paymentProductFields.validationErrors.%@.label"
        var errorMessageKey: String
        var errorMessageValue: String
        var errorMessage: String
        if let lengthError = errorClass as? ValidationErrorLength {
            if (lengthError.minLength == lengthError.maxLength) {
                errorMessageKey = String(format: errorMessageFormat, "length.exact");
            } else if (lengthError.minLength == 0 && lengthError.maxLength > 0) {
                errorMessageKey = String(format: errorMessageFormat, "length.max");
            } else if (lengthError.minLength > 0 && lengthError.maxLength > 0) {
                errorMessageKey = String(format: errorMessageFormat, "length.between");
            } else {
                // this case never happens
                errorMessageKey = ""
            }
            
            let errorMessageValueWithPlaceholders = NSLocalizedString(errorMessageKey, tableName: SDKConstants.kSDKLocalizable, bundle: AppConstants.sdkBundle, value: "", comment: "")
            let errorMessageValueWithPlaceholder = errorMessageValueWithPlaceholders.replacingOccurrences(of: "{maxLength}", with: String(lengthError.maxLength))
            errorMessage = errorMessageValueWithPlaceholder.replacingOccurrences(of: "{minLength}", with: String(lengthError.minLength))
        } else if let rangeError = errorClass as? ValidationErrorRange {
            errorMessageKey = String(format: errorMessageFormat, "length.between")
            let errorMessageValueWithPlaceholders = NSLocalizedString(errorMessageKey, tableName: SDKConstants.kSDKLocalizable, bundle: AppConstants.sdkBundle, value: "", comment: "")
            var minString = ""
            var maxString = ""
            if withCurrency {
                minString = String(format: "%.2f", Double(rangeError.minValue) / 100)
                maxString = String(format: "%.2f", Double(rangeError.maxValue) / 100)
            }
            else {
                minString = "\(Int(rangeError.minValue))"
                maxString = "\(Int(rangeError.maxValue))"
            }
            let errorMessageValueWithPlaceholder = errorMessageValueWithPlaceholders.replacingOccurrences(of: "{maxValue}", with: String(maxString))
            errorMessage = errorMessageValueWithPlaceholder.replacingOccurrences(of: "{minValue}", with: String(minString))
            
        } else if let errorMessageFromClass = errorClass.errorMessageKey() {
            errorMessageKey = String(format: errorMessageFormat, errorMessageFromClass)
            errorMessageValue = NSLocalizedString(errorMessageKey, tableName: SDKConstants.kSDKLocalizable, bundle: AppConstants.sdkBundle, value: "", comment: "")
            errorMessage = errorMessageValue
        } else {
            errorMessage = ""
            NSException(name: NSExceptionName(rawValue: "Invalid validation error"), reason: "Validation error \(error) is invalid", userInfo: nil).raise()
        }
        
        return errorMessage
    }
}

