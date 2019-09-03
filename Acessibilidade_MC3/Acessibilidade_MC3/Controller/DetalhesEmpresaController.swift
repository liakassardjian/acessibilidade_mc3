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
                cell.avaliacaoLabel.text = String(format: "%.1f", empresa.nota)
                cell.barraProgressoView.valorProgresso = CGFloat(empresa.nota / 5)
                cell.recomendacaoLabel.text = String("\(empresa.recomendacao)%")
                
                if let site = empresa.site {
                    cell.siteLabel.text = site
                    cell.siteLinha.isHidden = false
                } else {
                    cell.siteLinha.isHidden = true
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
                cell.notaLabel.text = String(avaliacao.nota)
                cell.vantagensLabel.text = avaliacao.vantagens
                cell.desvantagensLabel.text = avaliacao.desvantagens
                
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
    
    private func retornaDataString(data: Date) -> String {
        let dia = Calendar.current.component(.day, from: data)
        let mes = Calendar.current.component(.month, from: data)
        let ano = Calendar.current.component(.year, from: data)
        
        let meses = ["janeiro", "fevereiro", "março", "abril", "maio", "junho", "julho", "agosto", "setembro", "outubro", "novembro", "dezembro"]
        
        return "\(dia) de \(meses[mes-1]) de \(ano)"
    }
    
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
