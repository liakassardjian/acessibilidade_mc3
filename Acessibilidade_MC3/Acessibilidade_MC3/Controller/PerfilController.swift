//
//  PerfilController.swift
//  Acessibilidade_MC3
//
//  Created by Luiz Henrique Monteiro de Carvalho on 01/02/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import Foundation
import UIKit

class PerfilController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    var avaliacoes: [Avaliacao]
    
    init(idUsuario: String) {
        
        let avaliacaoCodable = InternEmpresaAcessivel.getAvaliacoesUsuario(uuid: idUsuario)
        for elemento in avaliacaoCodable {
            let novaAvaliacao = Avaliacao()
            novaAvaliacao.converteAvaliacao(avaliacao: elemento)
            avaliacoes.append(novaAvaliacao)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (avaliacoes.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "avaliacaoCell", for: indexPath) as? AvaliacaoTableViewCell else {
            return UITableViewCell()
        }
        
        var avaliacoesEmpresa: [Avaliacao]?
        avaliacoesEmpresa = empresa?.avaliacoes
        
        if let avaliacoes = avaliacoesEmpresa {
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
            
            if let sugestoes = avaliacao.sugestoes,
                sugestoes != "" {
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
