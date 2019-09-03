//
//  AvaliarDeficienciasViewController.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 28/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class AvaliarDeficienciasViewController: UIViewController {
    
    var acessibilidadeFisica: Bool = false
    @IBAction func alteraFisico(_ sender: UIButton) {
        acessibilidadeFisica = alteraAcessibilidade(acessivel: acessibilidadeFisica,
                                                    imagemFalse: (UIImage(named: "SIA"))!,
                                                    imagemTrue: (UIImage(named: "SIACheck"))!,
                                                    sender: sender)
    }
    
    var acessibilidadeVisual: Bool = false
    @IBAction func alteraVisual(_ sender: UIButton) {
        acessibilidadeVisual = alteraAcessibilidade(acessivel: acessibilidadeVisual,
                                                    imagemFalse: (UIImage(named: "SIDV"))!,
                                                    imagemTrue: (UIImage(named: "SIDVCheck"))!,
                                                    sender: sender)
    }
    
    var acessibilidadeAuditiva: Bool = false
    @IBAction func alteraAuditiva(_ sender: UIButton) {
        acessibilidadeAuditiva = alteraAcessibilidade(acessivel: acessibilidadeAuditiva,
                                                      imagemFalse: UIImage(named: "SIDA")!,
                                                      imagemTrue: UIImage(named: "SIDACheck")!,
                                                      sender: sender)
    }
    
    var acessibilidadeIntelectual: Bool = false
    @IBAction func alteraIntelectual(_ sender: UIButton) {
        acessibilidadeIntelectual = alteraAcessibilidade(acessivel: acessibilidadeIntelectual,
                                                         imagemFalse: UIImage(named: "SDI")!,
                                                         imagemTrue: UIImage(named: "SDICheck")!,
                                                         sender: sender)
    }
    
    var acessibilidadeNanismo :Bool = false
    @IBAction func alteraNanismo(_ sender: UIButton) {
        acessibilidadeNanismo = alteraAcessibilidade(acessivel: acessibilidadeNanismo, imagemFalse: UIImage(named: "SPN")!, imagemTrue: UIImage(named: "SPNCheck")!, sender: sender)
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
}
