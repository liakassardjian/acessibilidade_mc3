//
//  PerfilViewController.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 23/01/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

class PerfilViewController: UITableViewController {
    
    @IBOutlet weak var celulaLogout: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}
