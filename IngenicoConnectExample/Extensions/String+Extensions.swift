//
//  String+Extensions.swift
//  IngenicoConnectExample
//
//  Copyright © 2022 Global Collect Services. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
         return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
