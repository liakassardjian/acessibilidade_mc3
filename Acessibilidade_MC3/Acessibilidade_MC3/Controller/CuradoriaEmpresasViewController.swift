//
//  CuradoriaEmpresasViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 22/01/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class CuradoriaEmpresasViewController: UIViewController {

    /**
     Usuário que está utilizando o aplicativo no momento.
     
     É representado por uma string opcional.
     */
    var usuario: String?
    
    /**
    Conector da Table View que lista as empresas existentes.
    */
    @IBOutlet weak var empresasTableView: UITableView!
    
    /**
     Conector da Segmented Control que muda a visualização das empresas.
    */
    @IBOutlet weak var estadoSegmentedControl: UISegmentedControl!
    
    /**
     Delegate e Data Source das empresas.
     
     Representado por EmpresasController opcional.
     */
    var empresasDataSourceDelegate: EmpresasController?
    
    /**
     Lista de empresas existentes no sistema.
     
     Recebe valor da tela que a chama, mas é inicializada como um vetor vazio.
     */
    var empresas: [Empresa] = []
    
    /**
     Referência à tela anterior.
     */
    weak var empresasViewController: EmpresasViewController?
    
    @IBOutlet weak var activIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        empresasDataSourceDelegate = EmpresasController(tableView: empresasTableView)
        empresasTableView.delegate = empresasDataSourceDelegate
        empresasTableView.dataSource = empresasDataSourceDelegate
        
        exibirEmpresas(estado: .pendente)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        activIndicator.isHidden = false
        activIndicator.startAnimating()
        empresasViewController?.getEmpresas()
        sleep(1)
        activIndicator.stopAnimating()
        activIndicator.isHidden = true
        empresas = empresasViewController?.empresas ?? [Empresa]()
        if let estado = estadoSegmentedControl?.selectedSegmentIndex {
            switch estado {
            case 0:
                exibirEmpresas(estado: .pendente)
            case 1:
                exibirEmpresas(estado: .reprovado)
            case 2:
                exibirEmpresas(estado: .aprovado)
            default:
                break
            }
        }
    }
    
    @IBAction func mudarCategoriaEstado(_ sender: Any) {
        switch estadoSegmentedControl.selectedSegmentIndex {
        case 0:
            exibirEmpresas(estado: .pendente)
        case 1:
            exibirEmpresas(estado: .reprovado)
        case 2:
            exibirEmpresas(estado: .aprovado)
        default:
            break
        }
    }
    
    func exibirEmpresas(estado: Estado) {
        var empresasEstado = [Empresa]()
        for e in empresas {
            if e.status == estado {
                empresasEstado.append(e)
            }
        }
        empresasDataSourceDelegate?.empresas = empresasEstado
        empresasTableView.reloadData()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detalhes = segue.destination as? CuradoriaDetalhesViewController {
            if let selecionada = empresasTableView.indexPathForSelectedRow {
                detalhes.empresa = empresasDataSourceDelegate?.empresas[selecionada.row]
                detalhes.usuario = usuario
            }
        }
    }

}
