//
//  CuradoriaEmpresasTVC.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 16/01/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class CuradoriaEmpresasTVC: UITableViewController {

    var empresas: [Empresa] = []
    
//    var usuario: String?
//    let usuarioUUID = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        getEmpresas()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let defaults = UserDefaults()
//        let primeiroAcesso = defaults.bool(forKey: "primeiroAcesso")
//        if !primeiroAcesso {
//            registraUsuario(uuid: UUID().uuidString)
//            defaults.set(true, forKey: "primeiroAcesso")
//        } else {
//            usuario = UserDefaults.standard.string(forKey: "UserId")
//        }
        // TODO: dados inseridos localmente para teste das telas provisórias
        let avaliacao1 = Avaliacao()
        avaliacao1.titulo = "Avaliação 1"
        avaliacao1.status = .aprovado
        
        let avaliacao2 = Avaliacao()
        avaliacao2.titulo = "Avaliação 2"
        avaliacao2.status = .reprovado
        
        let avaliacao3 = Avaliacao()
        avaliacao3.titulo = "Avaliação 3"
        avaliacao3.status = .pendente

        empresas.append(Empresa())
        empresas.last?.nome = "Empresa 1"
        empresas.last?.status = .aprovado
        empresas.last?.avaliacoes.append(avaliacao1)
        
        empresas.append(Empresa())
        empresas.last?.nome = "Empresa 2"
        empresas.last?.status = .reprovado
        empresas.last?.avaliacoes.append(avaliacao2)
        empresas.last?.avaliacoes.append(avaliacao3)
        
        empresas.append(Empresa())
        empresas.last?.nome = "Empresa 3"
        empresas.last?.status = .pendente
        empresas.last?.avaliacoes.append(avaliacao1)
        empresas.last?.avaliacoes.append(avaliacao2)
        empresas.last?.avaliacoes.append(avaliacao3)
        
        getEmpresas()
        tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empresas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "empresa", for: indexPath)

        cell.textLabel?.text = empresas[indexPath.row].nome
        
        var texto = ""
        switch empresas[indexPath.row].status {
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
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let avaliacaoes = segue.destination as? CuradoriaAvaliacoesTVC {
            if let selecionada = tableView.indexPathForSelectedRow {
                avaliacaoes.empresa = empresas[selecionada.row]
            } else {
                avaliacaoes.empresa = empresas.last
            }
        }
    }
//    func registraUsuario(uuid: String) {
//        UsuarioRequest().usuarioCreate(uuid: uuid, usuario: UsuarioCodable(), completion: { (response, error) in
//            if response != nil {
//                self.usuarioUUID.set(uuid, forKey: "UserId")
//                self.usuario = UserDefaults.standard.string(forKey: "UserId")
//                print("sucesso")
//            } else {
//                print("else")
//            }
//            })
//    }
    
    
    
    
//    func updateEmpresa(empresa: Empresa, estado: Estado) {
//        let empresaCodable = EmpresaCodable(_id: empresa.id,
//                                                nome: empresa.nome,
//                                                site: empresa.site,
//                                                telefone: empresa.telefone,
//                                                media: 0,
//                                                mediaRecomendacao: 0,
//                                                cidade: empresa.cidade,
//                                                estado: empresa.estado,
//                                                estadoPendenteEmpresa: estado.rawValue, avaliacao: [])
//
//            if let usuario = usuario {
//
//            EmpresaRequest().updateEmpresa(uuid: usuario, empresa: empresaCodable) { (response, error) in
//                                                    if response != nil {
//                                                        print("sucesso")
//                                                    } else {
//                                                        print("erro")
//                                                    }
//                    }
//
//                }
//    }
    
    
    
    
//    func registraEmpresa(empresa: Empresa) {
//        let empresaCodable = EmpresaCodable(_id: nil,
//                                            nome: empresa.nome,
//                                            site: empresa.site,
//                                            telefone: empresa.telefone,
//                                            media: 0,
//                                            mediaRecomendacao: 0,
//                                            cidade: empresa.cidade,
//                                            estado: empresa.estado,
//                                            estadoPendenteEmpresa: empresa.status.rawValue, avaliacao: [])
//
//        if let usuario = usuario {
//            EmpresaRequest().empresaCreate(uuid: usuario,
//                                           empresa: empresaCodable) { (response, error) in
//                                            if response != nil {
//                                                print("sucesso")
//                                            } else {
//                                                print("erro")
//                                            }
//            }
//
//        }
//    }
    
    
    func getEmpresas() {
        var empresasLocal: [Empresa] = []
        
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
                            empresasLocal.append(novaEmpresa)
                    }
                }
                self.empresas = empresasLocal
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
                
            case .error(description: let description):
                print(description)
            }
        })
        
    }
    
    func converteAvaliacoes(avaliacaoCodable: [AvaliacaoCodable?]) -> [Avaliacao] {
        var avaliacoes: [Avaliacao] = []
        
        for avaliacao in avaliacaoCodable {
            if let titulo = avaliacao?.titulo,
                let status = avaliacao?.estadoPendenteAvaliacao,
                let id = avaliacao?._id {
                let novaAvaliacao = Avaliacao()
                novaAvaliacao.titulo = titulo
                novaAvaliacao.id = id
                
                switch status {
                case 1:
                    novaAvaliacao.status = .aprovado
                case -1:
                    novaAvaliacao.status = .reprovado
                default:
                    novaAvaliacao.status = .pendente
                }
                avaliacoes.append(novaAvaliacao)
            }
        }
        
        return avaliacoes
    }
    
    

}
