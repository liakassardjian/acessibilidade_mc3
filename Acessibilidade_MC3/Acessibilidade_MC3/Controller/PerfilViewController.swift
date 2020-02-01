//
//  PerfilViewController.swift
//  Acessibilidade_MC3
//
//  Created by Luiz Henrique Monteiro de Carvalho on 01/02/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class PerfilViewController: UIViewController {
    
    @IBOutlet weak var perfilTableView: UITableView!
    
    var perfilController: PerfilController?
    
    override func viewDidLoad() {
        
        perfilController = PerfilController()
        perfilTableView.delegate = perfilController
        perfilTableView.dataSource = perfilController
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
