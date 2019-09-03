//
//  DetalhesEmpresaViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 29/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class DetalhesEmpresaViewController: UIViewController {

    @IBOutlet weak var detalhesTableView: UITableView!
    
    var detalhesDataSourceDelegate: DetalhesEmpresaController?
    
    var empresa: Empresa?
    var avaliacao: Avaliacao?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detalhesDataSourceDelegate = DetalhesEmpresaController()
        detalhesTableView.delegate = detalhesDataSourceDelegate
        detalhesTableView.dataSource = detalhesDataSourceDelegate
        
        detalhesDataSourceDelegate?.empresa = self.empresa
        
        let headerNib = UINib.init(nibName: "AvaliacaoHeaderView", bundle: Bundle.main)
        detalhesTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "AvaliacaoHeaderView")
        
        navigationItem.title = empresa?.nome
        
    }

    @IBAction func adicionaAvaliacao(_ sender: UIStoryboardSegue) {
        if sender.source is AvaliarProsViewController {
            if let senderAdd = sender.source as? AvaliarProsViewController {
                if let avaliacao = senderAdd.avaliacao {
                    self.avaliacao = avaliacao
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let avaliacao = avaliacao {
            empresa?.adicionaAvaliacao(avaliacao: avaliacao)
            self.avaliacao = nil
        }
        
        detalhesTableView.reloadData()
    }
}
