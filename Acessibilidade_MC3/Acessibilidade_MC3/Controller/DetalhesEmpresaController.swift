//
//  DetalhesEmpresaController.swift
//  Acessibilidade_MC3
//
//  Created by Lia Kassardjian on 29/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

class DetalhesEmpresaController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let titulos = ["Informações da empresa", "Avaliações"]
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
                
                cell.localizacaoView.accessibilityValue = "Localização \(empresa.localizacao)"
                cell.avaliacaoLabel.text = String(format: "%.1f", empresa.nota)
                cell.barraProgressoView.valorProgresso = CGFloat(empresa.nota / 5)
                cell.recomendacaoLabel.text = String("\(empresa.recomendacao)%")
                
                if let avaNotaAcessivel = cell.avaliacaoLabel.text, let recAcessivel =  cell.recomendacaoLabel.text {
                    cell.avaliacaoRecomendacaoView.accessibilityValue = "Nota \(avaNotaAcessivel) de 5, e \(recAcessivel) dos funcionários recomendam"
                    
                }
                
                if let site = empresa.site {
                    cell.siteLabel.text = site
                    cell.siteLinha.isHidden = false
                    cell.siteView.accessibilityValue = "Site \(site)"
                    if site == "" {
                        cell.siteLinha.isHidden = true
                    }
                } else {
                    cell.siteLinha.isHidden = true
                }
            
                if let telefone = empresa.telefone {
                    cell.telefoneLabel.text = telefone
                    cell.telefoneLinha.isHidden = false
                    cell.telefoneView.accessibilityValue = "Telefone \(telefone)"
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
                cell.dataLabel.isAccessibilityElement = true
                if let dataLabelAvaliacao = cell.dataLabel.text {
                    cell.dataLabel.accessibilityLabel = "Avaliação feita em \(dataLabelAvaliacao)"
                }
                cell.tituloLabel.text = avaliacao.titulo
                cell.tituloLabel.isAccessibilityElement = true
                cell.notaLabel.text = String(format: "%.1f", avaliacao.nota)
                cell.notaLabel.isAccessibilityElement = true
                cell.notaLabel.accessibilityValue = "de 5"
                cell.vantagensLabel.text = avaliacao.vantagens
                cell.vantagensLabel.isAccessibilityElement = true
                cell.desvantagensLabel.text = avaliacao.desvantagens
                cell.desvantagensLabel.isAccessibilityElement = true
                cell.barraProgressoView.valorProgresso = CGFloat(avaliacao.nota / 5)
                cell.vantagensTituloLabel.isAccessibilityElement = true
                cell.desvantagensTituloLabel.isAccessibilityElement = true
                cell.sugestoesTituloLabel.isAccessibilityElement = true
                
                if avaliacao.cargo == .exFunc {
                    cell.cargoLabel.text = "Funcionário até \(avaliacao.ultimoAno)"
                } else {
                    cell.cargoLabel.text = avaliacao.cargo.rawValue
                }
                cell.cargoLabel.text = "\(cell.cargoLabel.text ?? "") - \(avaliacao.posicao)"
                cell.cargoLabel.isAccessibilityElement = true
                
                if avaliacao.recomendacao {
                    cell.recomendaLabel.text = "Recomenda esta empresa"
                    cell.recomendaImagem.image = UIImage(named: "RecomendaTrue")
                    cell.recomendaLabel.isAccessibilityElement = true
                } else {
                    cell.recomendaLabel.text = "Não recomenda esta empresa"
                    cell.recomendaImagem.image = UIImage(named: "NaoRecomendaTrue")
                    cell.recomendaLabel.isAccessibilityElement = true
                }
                
                if let sugestoes = avaliacao.sugestoes {
                    cell.sugestoesLabel.text = sugestoes
                    cell.sugestoesTituloLabel.isHidden = false
                    cell.sugestoesLabel.isHidden = false
                    cell.sugestoesTituloLabel.isAccessibilityElement = true
                    cell.sugestoesLabel.isAccessibilityElement = true
                    
                } else {
                    cell.sugestoesTituloLabel.isHidden = true
                    cell.sugestoesLabel.isHidden = true
                    cell.sugestoesTituloLabel.isAccessibilityElement = true
                    cell.sugestoesTituloLabel.accessibilityValue = ""
                    cell.sugestoesLabel.isAccessibilityElement = true
                    cell.sugestoesLabel.accessibilityValue = ""
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
    
    private func retornaDataString(data: Date) -> String {
        let dia = Calendar.current.component(.day, from: data)
        let mes = Calendar.current.component(.month, from: data)
        let ano = Calendar.current.component(.year, from: data)
        
        let meses = ["janeiro", "fevereiro", "março", "abril", "maio", "junho", "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"]
        
        return "\(dia) de \(meses[mes-1]) de \(ano)"
    }
    
    private func exibeSimbolosAcessibilidade(imagens: [UIImageView], acessibilidade: [Acessibilidade]) {
        var contador: Int = 0
        var acessibilidadeAcessivel: String = "Empresa acessível para funcionários com "
        for acessivel in acessibilidade {
            imagens[contador].image = UIImage(named: acessivel.rawValue)
            imagens[contador].layer.cornerRadius = 8
            imagens[contador].isAccessibilityElement = true
            switch acessivel {
            case.deficienciaAuditiva: acessibilidadeAcessivel += ", deficiência auditiva "
            case.deficienciaMotora: acessibilidadeAcessivel += ", deficiência motora "
            case.deficienciaVisual: acessibilidadeAcessivel += ", deficiência visual "
            case.deficienciaIntelectual: acessibilidadeAcessivel += ", deficiência intelectual "
            case.nanismo:acessibilidadeAcessivel += ", nanismo "
            }
            
            contador += 1
        }
        
        for cont in contador..<5 {
            imagens[cont].isHidden = true
        }
    }

}
