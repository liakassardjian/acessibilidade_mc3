//
//  AvaliarDeficienciasViewController.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 28/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class AvaliarDeficienciasViewController: UIViewController {
    
    var avaliacao: Avaliacao?
    var empresa: Empresa?
    
    var acessibilidadeFisica: Bool = false
    @IBAction func alteraFisico(_ sender: UIButton) {
        if let falseImage = UIImage(named: "SIA"), let trueImage = UIImage(named: "SIACheck") {
            acessibilidadeFisica = alteraAcessibilidade(acessivel: acessibilidadeFisica,
                                                        imagemFalse: falseImage,
                                                        imagemTrue: trueImage,
                                                        sender: sender)
        }
    }
    
    var acessibilidadeVisual: Bool = false
    @IBAction func alteraVisual(_ sender: UIButton) {
        if let falseImage = UIImage(named: "SIDV"), let trueImage = UIImage(named: "SIDVCheck") {
            acessibilidadeVisual = alteraAcessibilidade(acessivel: acessibilidadeVisual,
                                                        imagemFalse: falseImage,
                                                        imagemTrue: trueImage,
                                                        sender: sender)
        }
    }
    
    var acessibilidadeAuditiva: Bool = false
    @IBAction func alteraAuditiva(_ sender: UIButton) {
        if let falseImage = UIImage(named: "SIDA"), let trueImage = UIImage(named: "SIDACheck") {
            acessibilidadeAuditiva = alteraAcessibilidade(acessivel: acessibilidadeAuditiva,
                                                          imagemFalse: falseImage,
                                                          imagemTrue: trueImage,
                                                          sender: sender)
        }
    }
    
    var acessibilidadeIntelectual: Bool = false
    @IBAction func alteraIntelectual(_ sender: UIButton) {
        if let falseImage = UIImage(named: "SDI"), let trueImage = UIImage(named: "SDICheck") {
            acessibilidadeIntelectual = alteraAcessibilidade(acessivel: acessibilidadeIntelectual,
                                                             imagemFalse: falseImage,
                                                             imagemTrue: trueImage,
                                                             sender: sender)
        }
    }
    
    var acessibilidadeNanismo: Bool = false
    @IBAction func alteraNanismo(_ sender: UIButton) {
        if let falseImage = UIImage(named: "SPN"), let trueImage = UIImage(named: "SPNCheck") {
            acessibilidadeNanismo = alteraAcessibilidade(acessivel: acessibilidadeNanismo,
                                                         imagemFalse: falseImage,
                                                         imagemTrue: trueImage,
                                                         sender: sender)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ajustarUI()

    }
    
    func ajustarUI() {
        navigationController?.navigationBar.tintColor = .rioCristalino

    }
    
    func alteraAcessibilidade(acessivel: Bool, imagemFalse: UIImage, imagemTrue: UIImage, sender: UIButton) -> Bool {
        if acessivel == false {
            sender.setImage(imagemTrue, for: .normal)
            sender.alpha = 1
            return true
        } else {
            sender.setImage(imagemFalse, for: .normal)
            sender.alpha = 0.5
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
