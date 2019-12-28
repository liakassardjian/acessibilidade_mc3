//
//  DetalhesEmpresaController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 29/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

/**
 Classe que controla os detalhes que serão exibidos da empresa previamente selecionada.
 
 A classe herda de NSObject, UITableViewDataSource e UITableViewDelegate, sendo, assim, Delegate e Data Source de uma determinada Table View.
 */
class DetalhesEmpresaController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    /**
     Títulos das seções da Table View exibidas na tela.
     */
    let titulos = ["Informações da empresa", "Avaliações"]
    
    /**
     Empresa cujos detalhes estão sendo exibidos na tela.
     
     Recebe um valor de uma instância da classe DetalhesEmpresaViewController.
     */
    var empresa: Empresa?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return titulos.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            if let avaliacoes = empresa?.avaliacoes {
                return avaliacoes.count
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? InformacoesTableViewCell else {
                return UITableViewCell()
            }
            
            if let empresa = empresa {
                cell.localizacaoLabel.text = empresa.localizacao
                cell.avaliacaoLabel.text = String(format: "%.1f", empresa.nota)
                cell.barraProgressoView.valorProgresso = CGFloat(empresa.nota / 5)
                cell.recomendacaoLabel.text = String("\(empresa.recomendacao)%")
                
                if let site = empresa.site {
                    cell.siteLabel.text = site
                    cell.siteLinha.isHidden = false
                    
                    if site == "" {
                        cell.siteLinha.isHidden = true
                    }
                } else {
                    cell.siteLinha.isHidden = true
                }
                
                if let telefone = empresa.telefone {
                    cell.telefoneLabel.text = telefone
                    cell.telefoneLinha.isHidden = false
                    
                    if telefone == "" {
                        cell.telefoneLinha.isHidden = true
                    }
                } else {
                    cell.telefoneLinha.isHidden = true
                }
                
                guard let imagens = cell.imagensAcessibilidade else {
                    return UITableViewCell()
                }
                
                exibeSimbolosAcessibilidade(imagens: imagens, acessibilidade: empresa.acessibilidade)
            }
            
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "avaliacaoCell", for: indexPath) as? AvaliacaoTableViewCell else {
                return UITableViewCell()
            }
            
            if let avaliacoes = empresa?.avaliacoes {
                let avaliacao = avaliacoes[indexPath.row]
                cell.dataLabel.text = retornaDataString(data: avaliacao.data)
                cell.tituloLabel.text = avaliacao.titulo
                cell.notaLabel.text = String(format: "%.1f", avaliacao.nota)
                cell.vantagensLabel.text = avaliacao.vantagens
                cell.desvantagensLabel.text = avaliacao.desvantagens
                cell.barraProgressoView.valorProgresso = CGFloat(avaliacao.nota / 5)
                
                if avaliacao.cargo == .exFunc {
                    cell.cargoLabel.text = "Funcionário até \(avaliacao.ultimoAno)"
                } else {
                    cell.cargoLabel.text = avaliacao.cargo.rawValue
                }
                cell.cargoLabel.text = "\(cell.cargoLabel.text ?? "") - \(avaliacao.posicao)"
                
                if avaliacao.recomendacao {
                    cell.recomendaLabel.text = "Recomenda esta empresa"
                    cell.recomendaImagem.image = UIImage(named: "RecomendaTrue")
                } else {
                    cell.recomendaLabel.text = "Não recomenda esta empresa"
                    cell.recomendaImagem.image = UIImage(named: "NaoRecomendaTrue")
                }
                
                if let sugestoes = avaliacao.sugestoes {
                    cell.sugestoesLabel.text = sugestoes
                    cell.sugestoesTituloLabel.isHidden = false
                    cell.sugestoesLabel.isHidden = false
                } else {
                    cell.sugestoesTituloLabel.isHidden = true
                    cell.sugestoesLabel.isHidden = true
                }
                
                guard let imagens = cell.imagensAcessibilidade else {
                    return UITableViewCell()
                }
                
                exibeSimbolosAcessibilidade(imagens: imagens, acessibilidade: avaliacao.acessibilidade)
                
            }
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "AvaliacaoHeaderView") as? AvaliacaoHeaderView else {
            return UITableViewHeaderFooterView()
        }
        
        var titulo = titulos[section]
        if section != 0 {
            if let empresa = empresa {
                titulo = "\(titulo) (\(String(describing: empresa.avaliacoes.count)))"                
            }
        }
        headerView.tituloLabel.text = titulo

        return headerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    /**
     Função privada que converte um objeto Date em uma data por extenso do tipo string.
     
     - parameters:
        - data: Objeto do tipo Date do qual serão retirados os valores para composição da string.
     
     - returns: Uma string correspondente à data por extenso, no modelo "31 de janeiro de 2019".
     */
    private func retornaDataString(data: Date) -> String {
        let dia = Calendar.current.component(.day, from: data)
        let mes = Calendar.current.component(.month, from: data)
        let ano = Calendar.current.component(.year, from: data)
        
        let meses = ["janeiro", "fevereiro", "março", "abril", "maio", "junho", "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"]
        
        return "\(dia) de \(meses[mes-1]) de \(ano)"
    }
    
    /**
     Função privada que exibe os símbolos de acessibilidade de acordo com a classificação da empresa.
     
     - parameters:
        - imagens: Lista de `UIImageView`, que são as views de imagens pertencentes às células de uma Table View.
        - acessibilidade: Lista de casos do enumerador `Acessibilidade` que são representados pelas imagens também passadas como parâmetro para esta função.
     
     */
    private func exibeSimbolosAcessibilidade(imagens: [UIImageView], acessibilidade: [Acessibilidade]) {
        var contador: Int = 0
        
        for acessivel in acessibilidade {
            imagens[contador].image = UIImage(named: acessivel.rawValue)
            imagens[contador].layer.cornerRadius = 8
            contador += 1
        }
        
        for cont in contador..<5 {
            imagens[cont].image = nil
        }
    }

}
