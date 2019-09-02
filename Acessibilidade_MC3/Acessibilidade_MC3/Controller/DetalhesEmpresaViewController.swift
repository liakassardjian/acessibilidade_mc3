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
    
//    @IBAction func avaliarEmpresa(_ sender: Any) {
//        let avaliarStoryboard = UIStoryboard.init(name: "Avaliar", bundle: nil)
//        let avaliarCargo = avaliarStoryboard.instantiateViewController(withIdentifier: "avaliarCargo")
//        
//        if let avaliar = avaliarCargo as? AvaliarCargoViewController {
//            avaliar.empresa = self.empresa
//        }
//        
//        self.navigationController?.pushViewController(avaliarCargo, animated: true)
//    }

    @IBAction func adicionaAvaliacao(_ sender: UIStoryboardSegue) {
        if sender.source is AvaliarProsViewController {
            if let senderAdd = sender.source as? AvaliarProsViewController {
                if let avaliacao = senderAdd.avaliacao {
                    empresa?.adicionaAvaliacao(avaliacao: avaliacao)
                    detalhesTableView.reloadData()
                }
            }
        }
    }
}
