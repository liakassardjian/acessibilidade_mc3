//
//  AvaliarEmpresaTableViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 22/01/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class AvaliarEmpresaTableViewController: UITableViewController {

    var empresa: Empresa?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "aprovacaoCell", for: indexPath)
            cell.textLabel?.text = "Aprovada"
            if let empresa = empresa {
                if empresa.status == .aprovado {
                    cell.accessoryType = .checkmark
                }
            }
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "reprovacaoCell", for: indexPath)
            cell.textLabel?.text = "Reprovada"
            if let empresa = empresa {
                if empresa.status == .reprovado {
                    cell.accessoryType = .checkmark
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let aprovadoCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        let reprovadoCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0))
        if indexPath.row == 0 {
            aprovadoCell?.accessoryType = .checkmark
            reprovadoCell?.accessoryType = .none
            empresa?.status = .aprovado
        } else {
            aprovadoCell?.accessoryType = .none
            reprovadoCell?.accessoryType = .checkmark
            empresa?.status = .reprovado
        }
    }

}
