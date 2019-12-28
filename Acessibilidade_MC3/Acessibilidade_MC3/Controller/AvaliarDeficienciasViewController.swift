//
//  AvaliarDeficienciasViewController.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 28/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

/**
Classe que controla a terceira tela do formulário de avaliação da empresa.

Nesta tela, o usuário atribui à empresa classificações de acessibilidade.
- - -
A classe herda de UIViewController.

*/
class AvaliarDeficienciasViewController: UIViewController {
    
    /**
    A avaliação que está sendo criada pelo usuário no momento.
    */
    var avaliacao: Avaliacao?
    
    /**
    A empresa que está sendo avaliada.
    */
    var empresa: Empresa?
    
    /**
     Booleano que representa a presença de acessibilidade para deficiência física.
     
     Inicializado como false.
     */
    var acessibilidadeFisica: Bool = false
    
    /**
     Conector da imagem que corresponde à classificação de acessibilidade para deficiência física.
     */
    @IBOutlet weak var siaImageView: UIImageView!
    
    /**
     Ação executada quando o botão correspondente à classificação de acessibilidade para deficiência física é tocado.
     
     - parameters:
        - sender: O botão tocado pelo usuário.
     */
    @IBAction func alteraFisico(_ sender: UIButton) {
        if let falseImage = UIImage(named: "SIA"), let trueImage = UIImage(named: "SIACheck") {
            acessibilidadeFisica = alteraAcessibilidade(acessivel: acessibilidadeFisica,
                                                        imagemFalse: falseImage,
                                                        imagemTrue: trueImage,
                                                        imageView: siaImageView)
        }
    }
    
    /**
    Booleano que representa a presença de acessibilidade para deficiência visual.
    
    Inicializado como false.
    */
    var acessibilidadeVisual: Bool = false
    
    /**
    Conector da imagem que corresponde à classificação de acessibilidade para deficiência visual.
    */
    @IBOutlet weak var sidvImageView: UIImageView!
    
    /**
    Ação executada quando o botão correspondente à classificação de acessibilidade para deficiência visual é tocado.
    
    - parameters:
       - sender: O botão tocado pelo usuário.
    */
    @IBAction func alteraVisual(_ sender: UIButton) {
        if let falseImage = UIImage(named: "SIDV"), let trueImage = UIImage(named: "SIDVCheck") {
            acessibilidadeVisual = alteraAcessibilidade(acessivel: acessibilidadeVisual,
                                                        imagemFalse: falseImage,
                                                        imagemTrue: trueImage,
                                                        imageView: sidvImageView)
        }
    }
    
    /**
    Booleano que representa a presença de acessibilidade para deficiência auditiva.
    
    Inicializado como false.
    */
    var acessibilidadeAuditiva: Bool = false
    
    /**
    Conector da imagem que corresponde à classificação de acessibilidade para deficiência auditiva.
    */
    @IBOutlet weak var sidaImageView: UIImageView!
    
    /**
    Ação executada quando o botão correspondente à classificação de acessibilidade para deficiência auditiva é tocado.
    
    - parameters:
       - sender: O botão tocado pelo usuário.
    */
    @IBAction func alteraAuditiva(_ sender: UIButton) {
        if let falseImage = UIImage(named: "SIDA"), let trueImage = UIImage(named: "SIDACheck") {
            acessibilidadeAuditiva = alteraAcessibilidade(acessivel: acessibilidadeAuditiva,
                                                          imagemFalse: falseImage,
                                                          imagemTrue: trueImage,
                                                          imageView: sidaImageView)
        }
    }
    
    /**
    Booleano que representa a presença de acessibilidade para deficiência intelectual.
    
    Inicializado como false.
    */
    var acessibilidadeIntelectual: Bool = false
    
    /**
    Conector da imagem que corresponde à classificação de acessibilidade para deficiência intelectual.
    */
    @IBOutlet weak var sdiImageView: UIImageView!
    
    /**
    Ação executada quando o botão correspondente à classificação de acessibilidade para deficiência intelectual é tocado.
    
    - parameters:
       - sender: O botão tocado pelo usuário.
    */
    @IBAction func alteraIntelectual(_ sender: UIButton) {
        if let falseImage = UIImage(named: "SDI"), let trueImage = UIImage(named: "SDICheck") {
            acessibilidadeIntelectual = alteraAcessibilidade(acessivel: acessibilidadeIntelectual,
                                                             imagemFalse: falseImage,
                                                             imagemTrue: trueImage,
                                                             imageView: sdiImageView)
        }
    }
    
    /**
    Booleano que representa a presença de acessibilidade para pessoas com nanismo.
    
    Inicializado como false.
    */
    var acessibilidadeNanismo: Bool = false
    
    /**
    Conector da imagem que corresponde à classificação de acessibilidade para pessoas com nanismo.
    */
    @IBOutlet weak var spnImageView: UIImageView!
    
    /**
    Ação executada quando o botão correspondente à classificação de acessibilidade para pessoas com nanismo é tocado.
    
    - parameters:
       - sender: O botão tocado pelo usuário.
    */
    @IBAction func alteraNanismo(_ sender: UIButton) {
        if let falseImage = UIImage(named: "SPN"), let trueImage = UIImage(named: "SPNCheck") {
            acessibilidadeNanismo = alteraAcessibilidade(acessivel: acessibilidadeNanismo,
                                                         imagemFalse: falseImage,
                                                         imagemTrue: trueImage,
                                                         imageView: spnImageView)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        siaImageView.alpha = 0.5
        sidvImageView.alpha = 0.5
        sidaImageView.alpha = 0.5
        sdiImageView.alpha = 0.5
        spnImageView.alpha = 0.5
    }
    
    /**
     Funçnao que altera a imagem correspondente a uma classificação de acessibilidade de acordo com o toque do usuário.
     
     - parameters:
        - acessivel: Booleano que indica se o usuário está informando que há acessibilidade ou não.
        - imagemFalse: Imagem que será exibida caso não haja a classe de acessibilidade.
        - imagemTrue: Imagem que será exibida caso haja a classe de acessibilidade.
        - imageView: Image View que conterá a `imagemFalse` ou `imagemTrue` conforme o caso.
     
     - returns: Booleano que indica se há esse caso de acessibilidade ou não.
     */
    func alteraAcessibilidade(acessivel: Bool, imagemFalse: UIImage, imagemTrue: UIImage, imageView: UIImageView) -> Bool {
        if acessivel == false {
            imageView.image = imagemTrue
            imageView.alpha = 1
            return true
        } else {
            imageView.image = imagemFalse
            imageView.alpha = 0.5
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if self.acessibilidadeFisica {
            avaliacao?.acessibilidade.append(.deficienciaMotora)
        }
        
        if self.acessibilidadeVisual {
            avaliacao?.acessibilidade.append(.deficienciaVisual)
        }
        
        if self.acessibilidadeAuditiva {
            avaliacao?.acessibilidade.append(.deficienciaAuditiva)
        }
        
        if self.acessibilidadeIntelectual {
            avaliacao?.acessibilidade.append(.deficienciaIntelectual)
        }
        
        if self.acessibilidadeNanismo {
            avaliacao?.acessibilidade.append(.nanismo)
        }
        
        if let avaliarTextos = segue.destination as? AvaliarProsViewController {
            avaliarTextos.avaliacao = self.avaliacao
            avaliarTextos.empresa = self.empresa
        }
    }
}
