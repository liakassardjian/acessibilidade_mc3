//
//  EmpresasViewController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 27/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit
import CloudKit
import Foundation

/**
 Classe que controla a view de exibição das empresas.
 
 Herda de UIViewController.
 */
class EmpresasViewController: UIViewController {
    
    /**
     Usuário que está utilizando o aplicativo no nomento.
     
     Representado por uma string opcional.
     */
    var usuario: String?

    /**
     Conector da Table View que lista as empresas existentes.
     */
    @IBOutlet weak var empresaTableView: UITableView!
    
    /**
     Conector do indicador de atividade presente na primeira tela.
     */
    @IBOutlet weak var activ: UIActivityIndicatorView!
    
    /**
     Controlador da barra de busca.
     
     Inicializado com nenhuma View Controller.
     */
    let searchController = UISearchController(searchResultsController: nil)
    
    /**
     Delegate e Data Source das empresas.
     
     Representado por EmpresasController opcional.
     */
    var empresasDataSourceDelegate: EmpresasController?
    
    /**
     Indicador da adição de uma nova empresa.
     
     Booleano inicializado com false.
    */
    var empresaAdicionada: Bool = false
    
    /**
     Lista de empresas existentes no sistema.
     
     Inicializada como vazia até que as empresas sejam buscadas do servidor.
     */
    var empresas: [Empresa] = []
    
    /**
     Container do CloudKit do qual é buscado o ID do usuário.
    
     Variável do tipo CKContainer opcional e é inicializada dentro da View Did Load.
    */
    private var container: CKContainer?
   
    /**
     Variável que recebe o ID do usuário quando este é encontrado no CloudKit.
    
     É do tipo CKRecord.ID opcional e é inicializada na função fetchUserId.
    */
    fileprivate var usuarioID: CKRecord.ID?

    /**
     Controlador de refresh da página ao puxar para baixo.
     */
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.regarregaPagina(_:)), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    /**
     Função que atualiza os dados da página através de GET no servidor.
     
     - parameters:
        - refreshControl: Instância de UIRefreshControl que recarrega a página.
     */
    @objc func regarregaPagina(_ refreshControl: UIRefreshControl) {
        getEmpresas()
        refreshControl.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        empresasDataSourceDelegate = EmpresasController(tableView: empresaTableView)
        getEmpresas()
        
        empresaTableView.delegate = empresasDataSourceDelegate
        empresaTableView.dataSource = empresasDataSourceDelegate
        
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Busca"
        self.searchController.searchBar.delegate = empresasDataSourceDelegate
        self.searchController.searchBar.isTranslucent = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.definesPresentationContext = true
        self.navigationItem.searchController = searchController
        
        container = CKContainer.default()
        fetchUserID {_ in
            self.usuario = self.usuarioID?.recordName
        }
        self.empresaTableView.addSubview(self.refreshControl)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        empresaTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let empresaInfo = segue.destination as? DetalhesEmpresaViewController {
            if let selecionada = empresaTableView.indexPathForSelectedRow {
                empresaInfo.empresa = empresasDataSourceDelegate?.empresas[selecionada.row]
            } else {
                empresaInfo.empresa = empresasDataSourceDelegate?.empresas.last
            }
        }
        
        if let novaEmpresa = segue.destination as? NovaEmpresaTableViewController {
            novaEmpresa.empresasViewController = self
        }
        
        if let adm = segue.destination as? CuradoriaEmpresasViewController {
            adm.empresas = empresas
            adm.usuario = usuario
            adm.empresasViewController = self
        }
    }
    
    /**
     Ação executada ao salvar uma nova empresa no sistema.
     
     A função é conectada com um botão na tela de adicionar uma empresa a fim de permitir o Exit daquela tela para esta. Permite que o indicador de atividade seja exibido.
     
     - parameters:
        - sender: A transição executada ao sair da tela.
     */
    @IBAction func adicionaEmpresa(_ sender: UIStoryboardSegue) {
        empresaAdicionada = true
    }
    
    /**
     Função que busca as empresas do servidor e armazena no controlador `empresasDataSourceDelegate`.
     */
    func getEmpresas() {
        var empresasLocal: [Empresa] = []
        var empresasDataSource: [Empresa] = []
        activ.startAnimating()
        activ.isHidden = false
        
        EmpresaRequest.getEmpresas(completion: { (responder) in
            switch responder {
            case .success(empresas: let empresas):
                for empresa in empresas {
                    
                    if let nome = empresa.nome,
                        let media = empresa.media,
                        let porcentagem = empresa.mediaRecomendacao,
                        let cidade = empresa.cidade,
                        let estado = empresa.estado,
                        let id = empresa._id,
                        let status = empresa.estadoPendenteEmpresa {
                        let novaEmpresa = Empresa(nome: nome,
                                                  site: empresa.site,
                                                  telefone: empresa.telefone,
                                                  cidade: cidade,
                                                  estado: estado,
                                                  id: id,
                                                  status: status)
                        
                        novaEmpresa.nota = Float(media)
                        novaEmpresa.recomendacao = Int(porcentagem)
                        
                        for avaliacao in self.converteAvaliacoes(avaliacaoCodable: empresa.avaliacao) {
                            novaEmpresa.criaAvaliacaoEmpresa(avaliacao: avaliacao)
                        }
                        if status != -1 {
                            empresasLocal.append(novaEmpresa)
                        }
                        empresasDataSource.append(novaEmpresa)
                    }
                }
                self.empresasDataSourceDelegate?.empresas = empresasLocal
                self.empresas = empresasDataSource
                DispatchQueue.main.async { [weak self] in
                    self?.empresaTableView.reloadData()
                    self?.activ.stopAnimating()
                    self?.activ.isHidden = true
                    if let empresasVC = self {
                        if empresasVC.empresaAdicionada {
                            empresasVC.performSegue(withIdentifier: "detalhesEmpresa", sender: empresasVC)
                            empresasVC.empresaAdicionada = false
                        }
                    }
                }
                
            case .error(description: let description):
                print(description)
            }
        })
        
    }
    
    /**
     Função que converte um vetor de `AvaliacaoCodable` opcional em um vetor de `Avaliacao`.
     
     - parameters:
        - avaliacaoCodable: Vetor de `AvaliacaoCodable ` opcional que será convertido em um vetor de `Avaliacao`.
     
     - returns: Vetor de `Avaliacao` já convertido.
     */
    func converteAvaliacoes(avaliacaoCodable: [AvaliacaoCodable?]) -> [Avaliacao] {
        var avaliacoes: [Avaliacao] = []
        
        for avaliacao in avaliacaoCodable {
            if let avaliacao = avaliacao {
                let novaAvaliacao = Avaliacao()
                novaAvaliacao.converteAvaliacao(avaliacao: avaliacao)
                avaliacoes.append(novaAvaliacao)
            }
        }
        
        return avaliacoes
    }
    
    /**
     Função que registra uma nova empresa no servidor.
     
     - parameters:
        - empresa: A empresa que está sendo criada.
     */
    func registraEmpresa(empresa: Empresa) {
        let empresaCodable = EmpresaCodable(_id: nil,
                                            nome: empresa.nome,
                                            site: empresa.site,
                                            telefone: empresa.telefone,
                                            media: 0,
                                            mediaRecomendacao: 0,
                                            cidade: empresa.cidade,
                                            estado: empresa.estado,
                                            estadoPendenteEmpresa: empresa.status.rawValue, avaliacao: [])
        
        if let usuario = usuario {
            EmpresaRequest().empresaCreate(uuid: usuario,
                                           empresa: empresaCodable) { (response, error) in
                                            if response != nil {
                                                print("sucesso")
                                            } else {
                                                print("erro")
                                            }
            }
        }
    }
    
    enum DataFetchAnswer {
        case fail(error: CKError, description: String)
        case successful(results:[CKRecord]?)
    }
    
    func fetchUserID(completionHandler: @escaping (DataFetchAnswer) -> Void) {
        if let container = container {
            container.fetchUserRecordID { (userID, error) in
                self.usuarioID = userID

                if let error = error as? CKError {
                    DispatchQueue.main.async {
                        completionHandler(.fail(error: error, description:
                            "Erro no Query da Cloud - Fetch: \(String(describing: error))"))
                    }
                    return
                }
                completionHandler(.successful(results: nil))
            }
        }
    }
    
}
