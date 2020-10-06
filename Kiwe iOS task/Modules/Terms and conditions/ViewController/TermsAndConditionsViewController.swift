//
//  TermsAndConditionsViewController.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/5/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import UIKit

class TermsAndConditionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
