//
//  ProfileViewController.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/5/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    private let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = viewModel.name
        ageLabel.text = viewModel.age
        emailLabel.text = viewModel.email
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
