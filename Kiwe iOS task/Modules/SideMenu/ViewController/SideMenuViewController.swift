//
//  SideMenuViewController.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/5/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import UIKit

class SideMenuViewController: UITableViewController {
    
    @IBOutlet var sideMenuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sideMenuButtonDidTap(indexPath.row)
    }
    
    private func sideMenuButtonDidTap(_ selection:Int){
        switch selection {
        case 0:
            dismiss(animated: true, completion: nil)
        case 1:
            let profileViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController")
            self.navigationController?.pushViewController(profileViewController, animated: true)
        case 2:
            let termsAndConditionsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TermsAndConditionsViewController")
            self.navigationController?.pushViewController(termsAndConditionsVC, animated: true)
        case 3:
            let signInViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "LoginAndRegisterViewController")
            UIApplication.shared.keyWindow?.rootViewController = signInViewController
        default:
            break
        }
    }
    
}
