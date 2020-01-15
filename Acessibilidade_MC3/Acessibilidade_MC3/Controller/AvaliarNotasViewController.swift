//
//  AvaliarNotas.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 28/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

/**
Classe que controla a segunda tela do formulário de avaliação da empresa.

Nesta tela, o usuário atribui quatro notas de 0 a 5 para a empresa, com base em integração com a equipe, cultura e valores, remuneração e benefícios e, por fim, oportunidade de crescimento.
- - -
A classe herda de UITableViewController, sendo, assim, Delegate e Data Source de uma determinada Table View.

*/
class AvaliarNotasViewController: UITableViewController {
    
    /**
     A avaliação que está sendo criada pelo usuário no momento.
     */
    var avaliacao: Avaliacao?
    
    /**
     A empresa que está sendo avaliada.
     */
    var empresa: Empresa?
    
    /**
     Conector da série de botões correspondentes com a nota de integração com a equipe.
     */
    @IBOutlet var integracaoBotoes: [UIButton]!
    
    /**
    Conector da série de imagens exibidas de acordo com a nota de integração com a equipe.
    */
    @IBOutlet var integracaoImagens: [UIImageView]!
    
    /**
     Nota dada à empresa na categoria de integração com a equipe.
     
     A nota é um float inicializado como 0.
     */
    var notaIntegracao: Float = 0
    
    /**
    Conector da série de botões correspondentes com a nota de cultura e valores.
    */
    @IBOutlet var culturaBotoes: [UIButton]!
    
    /**
    Conector da série de imagens exibidas de acordo com a nota de cultura e valores.
    */
    @IBOutlet var culturaImagens: [UIImageView]!
    
    /**
    Nota dada à empresa na categoria de cultura e valores.
    
    A nota é um float inicializado como 0.
    */
    var notaCultura: Float = 0
    
    /**
    Conector da série de botões correspondentes com a nota de remuneração e benefícios.
    */
    @IBOutlet var remuneracaoBotoes: [UIButton]!
    
    /**
    Conector da série de imagens exibidas de acordo com a nota de remuneração e benefícios.
    */
    @IBOutlet var remuneracaoImagens: [UIImageView]!
    
    /**
    Nota dada à empresa na categoria de remuneração e benefícios.
    
    A nota é um float inicializado como 0.
    */
    var notaRemuneracao: Float = 0
    
    /**
    Conector da série de botões correspondentes com a nota de oportunidade de crescimento.
    */
    @IBOutlet var oportunidadeBotoes: [UIButton]!
    
    /**
    Conector da série de imagens exibidas de acordo com a nota de oportunidade de crescimento.
    */
    @IBOutlet var oportunidadeImagens: [UIImageView]!
    
    /**
    Nota dada à empresa na categoria de  oportunidade de crescimento.
    
    A nota é um float inicializado como 0.
    */
    var notaOportunidade: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        integracaoBotoes.sort(by: { $0.tag < $1.tag })
        integracaoImagens.sort(by: { $0.tag < $1.tag })
        
        culturaBotoes.sort(by: { $0.tag < $1.tag })
        culturaImagens.sort(by: { $0.tag < $1.tag })
        
        remuneracaoBotoes.sort(by: { $0.tag < $1.tag })
        remuneracaoImagens.sort(by: { $0.tag < $1.tag })
        
        oportunidadeBotoes.sort(by: { $0.tag < $1.tag })
        oportunidadeImagens.sort(by: { $0.tag < $1.tag })
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        headerView.backgroundColor = .brancoAzulado
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    /**
     Ação executada quando o usuário seleciona uma nota para integração com a equipe.
     
     - parameters:
        - sender: Botão que chama a ação, no caso, algum dos botões em `integracaoBotoes`.
     */
    @IBAction func tocaIntegracao(_ sender: UIButton) {
        notaIntegracao = apertaBotao(botoes: integracaoBotoes, imagens: integracaoImagens, sender: sender)
    }
    
    /**
    Ação executada quando o usuário seleciona uma nota para cultura e valores.
    
    - parameters:
       - sender: Botão que chama a ação, no caso, algum dos botões em `culturaBotoes`.
    */
    @IBAction func tocaCultura(_ sender: UIButton) {
        notaCultura = apertaBotao(botoes: culturaBotoes, imagens: culturaImagens, sender: sender)
    }
    
    /**
    Ação executada quando o usuário seleciona uma nota para remuneração e benefícios.
    
    - parameters:
       - sender: Botão que chama a ação, no caso, algum dos botões em `remuneracaoBotoes`.
    */
    @IBAction func tocaRemuneracao(_ sender: UIButton) {
        notaRemuneracao = apertaBotao(botoes: remuneracaoBotoes, imagens: remuneracaoImagens, sender: sender)
    }
    
    /**
    Ação executada quando o usuário seleciona uma nota para oportunidade de crescimento.
    
    - parameters:
       - sender: Botão que chama a ação, no caso, algum dos botões em `oportunidadeBotoes`.
    */
    @IBAction func tocaOportunidade(_ sender: UIButton) {
        notaOportunidade = apertaBotao(botoes: oportunidadeBotoes, imagens: oportunidadeImagens, sender: sender)
    }
    
    /**
     Função que muda as imagens de uma série de acordo com o botão selecionado pelo usuário.
     
     - parameters:
        - botoes: Lista de botões selecionada pelo usuário.
        - imagens: Lista de imagens que precisam ser alteradas de acordo com os botões.
        - sender: Botão que foi tocado pelo usuário.
     
     - returns: A função retorna um float correspondente à tag do botão selecionado, a qual é equivalente à nota daquele botão.
     */
    func apertaBotao(botoes: [UIButton], imagens: [UIImageView], sender: UIButton) -> Float {
        for i in 0..<botoes.count {
            if botoes[i].tag <= sender.tag {
                imagens[i].image = UIImage(named: "GoldenStar")
            } else {
                imagens[i].image = UIImage(named: "Star")
            }
        }
        return Float(sender.tag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        avaliacao?.nota = media(valores: [notaIntegracao, notaCultura, notaRemuneracao, notaOportunidade])
        avaliacao?.integracao = Int(notaIntegracao)
        avaliacao?.cultura = Int(notaCultura)
        avaliacao?.remuneracao = Int(notaRemuneracao)
        avaliacao?.oportunidade = Int(notaOportunidade)
        
        if let avaliarEmpresa = segue.destination as? AvaliarDeficienciasViewController {
            avaliarEmpresa.avaliacao = self.avaliacao
            avaliarEmpresa.empresa = self.empresa
        }
    }
    
    /**
     Função privada que calcula a média de uma lista de valores do tipo float.
     
     - parameters:
        - valores: Vetor de float a partir do qual será feita a média.
     
     - returns: O valor da média como um float.
     */
    private func media(valores: [Float]) -> Float {
        var media: Float = 0
        
        for elemento in valores {
            media += elemento
        }
        media /= Float(valores.count)
        
        return media
    }
}
