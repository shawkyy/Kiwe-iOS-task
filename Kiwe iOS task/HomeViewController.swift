//
//  ViewController.swift
//  Kiwe iOS task
//
//  Created by Abdalla Shawky on 10/5/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import UIKit
import SideMenu

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sideMenuButtonDidTap(_ sender: Any) {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        let menu = SideMenuNavigationController(rootViewController: viewController)
        menu.leftSide = true
        menu.statusBarEndAlpha = 0
        menu.navigationBar.isHidden = true
        menu.dismissOnPresent = true
        menu.dismissOnPush = true
        present(menu, animated: true, completion: nil)
    }
}

