//
//  EmpresasViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 27/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit
import Foundation

class EmpresasViewController: UIViewController {

    @IBOutlet weak var empresaTableView: UITableView!
    
    let empresas = [Empresa(nome: "Mackenzie", localizacao: "São Paulo, SP", nota: 3.6, recomendacao: 77)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let empresasDataSourceDelegate = EmpresasController(empresas: empresas)
        empresaTableView.delegate = empresasDataSourceDelegate
        empresaTableView.dataSource = empresasDataSourceDelegate
        empresaTableView.rowHeight = 217
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

class Empresa {
    init(nome: String, localizacao: String, nota: Float, recomendacao: Int) {
        self.nome = nome
        self.localizacao = localizacao
        self.nota = nota
        self.recomendacao = recomendacao
    }
    
    var nome: String
    var localizacao: String
    var nota: Float
    var recomendacao: Int
}
