//
//  CuradoriaDetalhesViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 22/01/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class CuradoriaDetalhesViewController: UIViewController {

    /**
     Usuário que está utilizando o aplicativo no momento.
     
     É representado por uma string opcional.
     */
    var usuario: String?
    
    /**
    Conector da Table View que exibe os dados da empresa.
    */
    @IBOutlet weak var detalhesTableView: UITableView!
    
    /**
     Delegate e Data Source da empresa.
     
     Representado por DetalhesEmpresaController opcional.
     */
    var detalhesDataSourceDelegate: DetalhesEmpresaController?
    
    /**
     Empresa cujos detalhes são exibidos na tela.
  
     Recebe uma empresa de EmpresasViewController quando esta tela é chamada.
     */
    var empresa: Empresa?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detalhesDataSourceDelegate = DetalhesEmpresaController()
        detalhesTableView.delegate = detalhesDataSourceDelegate
        detalhesTableView.dataSource = detalhesDataSourceDelegate
        
        detalhesDataSourceDelegate?.empresa = self.empresa
        detalhesDataSourceDelegate?.adm = true
        
        let headerNib = UINib.init(nibName: "AvaliacaoHeaderView", bundle: Bundle.main)
        detalhesTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "AvaliacaoHeaderView")
        
        navigationItem.title = empresa?.nome
    }
    
    @IBAction func salvarAlteracoes(_ sender: UIStoryboardSegue) {
        if let empresa = empresa {
            atualizaEmpresa(empresa: empresa)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let avaliar = segue.destination as? AvaliarEmpresaTableViewController {
            avaliar.empresa = self.empresa
        }
    }
    
    func atualizaEmpresa(empresa: Empresa) {
        let empresaCodable = EmpresaCodable(_id: empresa.id,
                                            nome: empresa.nome,
                                            site: empresa.site,
                                            telefone: empresa.telefone,
                                            media: 0,
                                            mediaRecomendacao: 0,
                                            cidade: empresa.cidade,
                                            estado: empresa.estado,
                                            estadoPendenteEmpresa: empresa.status.rawValue, avaliacao: [])
        
        if let usuario = usuario {
            EmpresaRequest().updateEmpresa(uuid: usuario,
                                           empresa: empresaCodable) { (response, error) in
                                            if response != nil {
                                                print("sucesso")
                                            } else {
                                                print("erro")
                                            }
            }
        }
    }

}
