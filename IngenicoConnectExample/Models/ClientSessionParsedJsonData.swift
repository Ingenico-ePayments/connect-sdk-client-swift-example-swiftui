//
//  StartPaymentParsedJsonData.swift
//  IngenicoConnectExample
//
//  Copyright © 2022 Global Collect Services. All rights reserved.
//

import Foundation

struct ClientSessionParsedJsonData: Codable {
    var clientId: String?
    var customerId: String?
    var baseUrl: String?
    var assetUrl: String?

    private enum CodingKeys: String, CodingKey {
        case clientId = "clientSessionId"
        case customerId = "customerId"
        case baseUrl = "clientApiUrl"
        case assetUrl = "assetUrl"
    }
}
