//
//  LoginUsuarioViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 19/01/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class LoginUsuarioViewController: UIViewController {
    
    var containerViewController: ContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelar(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ContainerViewController,
                    segue.identifier == "embedSegue" {
            containerViewController = vc
            containerViewController?.superView = self
        }
    }

}
