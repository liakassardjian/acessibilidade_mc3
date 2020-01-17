//
//  CuradoriaAvaliacoesTVC.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 16/01/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class CuradoriaAvaliacoesTVC: UITableViewController {

    var empresa: Empresa?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empresa?.avaliacoes.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "avaliacao", for: indexPath)

        cell.textLabel?.text = empresa?.avaliacoes[indexPath.row].titulo
        var texto = ""
        switch empresa?.avaliacoes[indexPath.row].status {
        case .aprovado:
            texto = "Aprovada"
        case .reprovado:
            texto = "Reprovada"
        default:
            texto = "Pendente"
        }
        cell.detailTextLabel?.text = texto

        return cell
    }

}
