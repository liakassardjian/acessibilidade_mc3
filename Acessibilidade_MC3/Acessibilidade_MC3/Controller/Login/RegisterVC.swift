//
//  RegisterVC.swift
//  Acessibilidade_MC3
//
//  Created by Luiz Henrique Monteiro de Carvalho on 15/01/20.
//  Copyright © 2020 Lia Kassardjian. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    
    weak var superView: ContainerViewController?
    
    @IBAction func btnActionLogin(_ sender: Any) {
        let group = DispatchGroup() // initialize the async
        //spinner
        group.enter() // wait
        postRequest(nome: nome.text, email: email.text, password: senha.text) { (result, error) in
          if let result = result {
              print("success: \(result)")
              group.leave() // signal
          } else if let error = error {
              print("error: \(error.localizedDescription)")
              self.superView?.usuarioLogado = true
          }
        }

        group.notify(queue: .main) {
            self.superView?.usuarioLogado = true
            UserDefaults().set(true, forKey: "usuarioLogado")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func mudarTelaLogin(_ sender: Any) {
        if let superview = superView {
            superview.novoUsuario = false
        }
    }
    
    func postRequest(nome: String?, email: String?, password: String?, completion: @escaping ([String: Any]?, Error?) -> Void) {
            //declare parameter as a dictionary which contains string as key and value combination.
        guard let nome = nome else { return }
        guard let email = email else { return }
        guard let password = password else { return }
        let uuid = UUID().uuidString
        
        let parameters = ["nome": nome, "email": email, "senha": password, "uuid": uuid]
            
            //create the url with NSURL
        guard let url = URL(string: "http://localhost:3000/api/register") else { return }

            //create the session object
            let session = URLSession.shared

            //now create the Request object using the url object
            var request = URLRequest(url: url)
            request.httpMethod = "POST" //set http method as POST
            
            do {

                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                // pass dictionary to data object and set it as request body

            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
            
            //HTTP Headers
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            //create dataTask using the session object to send data to the server
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                
                guard let data = data else {
                    completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                    return
                }
                
                do {
                    //create json object from data
                    
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                        completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                        return
                    }
    //                print(json)
                    completion(json, nil)
                } catch let error {
                    print(error.localizedDescription)
                    completion(nil, error)
                }
            })
            
            task.resume()
        }
}
