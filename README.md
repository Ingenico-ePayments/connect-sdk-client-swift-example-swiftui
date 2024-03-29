# Ingenico Connect iOS (Swift) SDK example

**This example app has been rebranded to Worldline. As part of the rebranding the example app has moved to https://github.com/Worldline-Global-Collect/connect-sdk-client-swift-example-swiftui.**

---

This example app illustrates the use of the [Ingenico Connect Swift Client SDK](https://github.com/Ingenico-ePayments/connect-sdk-client-swift) and the services provided by Ingenico ePayments on the Ingenico ePayments platform.
This repository contains an example with screens written in SwiftUI. It demonstrates the UI and business logic required to perform a basic Credit Card payment. The steps supported are selecting a payment product, fill in the required payment details and encrypting those details.

See the [Ingenico Connect Developer Hub](https://epayments.developer-ingenico.com/documentation/sdk/mobile/swift/) for more information on how to use the SDK.

## Installation

To run this example app for the Ingenico Connect iOS (Swift) Client SDK, first clone the code from GitHub:

```
$ git clone https://github.com/Ingenico-ePayments/connect-sdk-client-swift-example-swiftui.git
```

Then use Cocoapods to install dependencies in the cloned repo:
```
$ pod install
```

Open the .xcworkspace project in Xcode and run the example application.

### How do I configure a session?

When you start the example you will see a form as the first screen where session details and payment details can be entered.

#### Session details

In order to use the SDK you need a session. This session can be created by making a Client Session request via in the Server to Server API.
It is also possible to use the API Explorer to obtain client session details. The JSON response with the Session id, Customer id, API URL and assets URL can be pasted in the appropriate fields.

#### Payment details

Set the payment details to any values you like to test a payment. Note that CountryCode, CurrencyCode and amount, as well as your configuration all influence which products will be available for the current payment.

