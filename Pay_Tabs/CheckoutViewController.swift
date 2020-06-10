//
//  CheckoutViewController.swift
//  PayTabs
//
//  Created by Rahul S on 09/06/20.
//  Copyright © 2020 Rahul S. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var pincodeTextField: UITextField!
    var initialSetupViewController: PTFWInitialSetupViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func TouchUpInsideActionOnProceedToPay(_ sender: Any) {
        
        
        let error = checkAllInformationEntered()
        guard error.isEmpty else {
            let alert = UIAlertController(title: "ERROR", message: error, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let bundle = Bundle(url: Bundle.main.url(forResource: "Resources", withExtension: "bundle")!)
        self.initialSetupViewController = PTFWInitialSetupViewController.init(
            bundle: bundle,
            andWithViewFrame: self.view.frame,
            andWithAmount: NumberFormatter().number(from: amountTextField.text!) as! Float,
            andWithCustomerTitle: "PayTabs Sample App",
            andWithCurrencyCode: "INR",
            andWithTaxAmount: 10.0,
            andWithSDKLanguage: "en",
            andWithShippingAddress: addressTextField.text!,
            andWithShippingCity: cityTextField.text!,
            andWithShippingCountry: "BHR",
            andWithShippingState: stateTextField.text!,
            andWithShippingZIPCode: "12345",
            andWithBillingAddress: "Manama",
            andWithBillingCity: "Manama",
            andWithBillingCountry: "BHR",
            andWithBillingState: "Manama",
            andWithBillingZIPCode: "12345",
            andWithOrderID: "12345",
            andWithPhoneNumber: "90322292560",
            andWithCustomerEmail: emailTextField.text!,
            andIsTokenization: false,
            andIsPreAuth: false,
            andWithMerchantEmail: "rahul@gmail.com",
            andWithMerchantSecretKey: "rHs252zzaHG22s9hi0ail3BToeSSHRo9zRbFTKe4rV7unhLGhWYCZAvoOohwgFFPxQuqBJv3EDx1UiHbeGNegjC5HUBYzhN78ixJ",
            andWithAssigneeCode: "SDK",
            andWithThemeColor:UIColor.red,
            andIsThemeColorLight: true)


        self.initialSetupViewController.didReceiveBackButtonCallback = {

        }

        self.initialSetupViewController.didStartPreparePaymentPage = {
          // Start Prepare Payment Page
          // Show loading indicator
        }
        self.initialSetupViewController.didFinishPreparePaymentPage = {
          // Finish Prepare Payment Page
          // Stop loading indicator
        }

        self.initialSetupViewController.didReceiveFinishTransactionCallback = {(responseCode, result, transactionID, tokenizedCustomerEmail, tokenizedCustomerPassword, token, transactionState) in
          print("Response Code: \(responseCode)")
          print("Response Result: \(result)")

          // In Case you are using tokenization
          print("Tokenization Cutomer Email: \(tokenizedCustomerEmail)");
          print("Tokenization Customer Password: \(tokenizedCustomerPassword)");
          print("TOkenization Token: \(token)");
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "PaymentResultViewControllerntroller") as PaymentResultViewControllerntroller
            vc.result = result
            self.present(vc, animated: true, completion: nil)
            
        }

        self.view.addSubview(initialSetupViewController.view)
        self.addChild(initialSetupViewController)

        initialSetupViewController.didMove(toParent: self)
        
        
    }
    
    func checkAllInformationEntered() -> String {
        if amountTextField.text!.isEmpty {
            return "Please enter amount"
        } else if nameTextField.text!.count < 2 && nameTextField.text!.count > 40 {
            return "Invalid name"
        }else if emailTextField.text!.isEmpty {
            return "Please enter your email id"
        } else if !emailTextField.text!.isValidEmail() {
            return "Please enter valid email"
        } else if phoneNumberTextField.text!.isEmpty {
            return "Please enter phone number"
        } else if addressTextField.text!.isEmpty {
            return "Please enter address"
        } else if cityTextField.text!.isEmpty {
            return "Please enter city"
        } else if stateTextField.text!.isEmpty {
            return "Please enter state"
        } else if countryTextField.text!.isEmpty {
            return "Please enter country"
        } else if pincodeTextField.text!.isEmpty {
            return "Password enter pin code"
        }
        return ""
    }
    
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
