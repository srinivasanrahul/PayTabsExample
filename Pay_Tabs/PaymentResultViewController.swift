//
//  PaymentResultViewController.swift
//  PayTabs
//
//  Created by Rahul S on 09/06/20.
//  Copyright © 2020 Rahul S. All rights reserved.
//

import UIKit

class PaymentResultViewControllerntroller: UIViewController {

    @IBOutlet weak var responseTextView: UITextView!
    var result: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let result = result {
            responseTextView.text = result
        }
    }

    @IBAction func touchUpInsideActionOnCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

