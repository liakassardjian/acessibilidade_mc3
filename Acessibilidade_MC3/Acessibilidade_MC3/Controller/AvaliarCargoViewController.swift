//
//  AvaliarCargo.swift
//  Acessibilidade_MC3
//
//  Created by Amaury A V A Souza on 28/08/19.
//  Copyright © 2019 Lia Kassardjian. All rights reserved.
//

import UIKit

class AvaliarCargoViewController: UITableViewController {
    @IBOutlet weak var cargoTextField: UITextField!
    
    @IBOutlet weak var funcionarioAtualmenteSwitch: UISwitch!
    @IBOutlet weak var desligadoEmPickerView: UIPickerView!
    @IBOutlet weak var trabalhouDurantePickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let trabalhouDuranteDelegateDataSource = PickerController(componentes: ["Menos de 3 meses",
                                                                                "Menos de 1 ano",
                                                                                "1 a 5 anos",
                                                                                "5 a 10 anos",
                                                                                "Mais de 10 anos"])
        trabalhouDurantePickerView.delegate = trabalhouDuranteDelegateDataSource
        trabalhouDurantePickerView.dataSource = trabalhouDuranteDelegateDataSource
        
        let desligadoEmDelegateDataSource = PickerController(componentes: ["2019",
                                                                           "2018",
                                                                           "2017",
                                                                           "2016",
                                                                           "2015 ou anteriormente"])
        desligadoEmPickerView.dataSource = desligadoEmDelegateDataSource
        desligadoEmPickerView.delegate = desligadoEmDelegateDataSource
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func switchAlterado(_ sender: Any) {
        let indexPath = IndexPath(indexes: [4,1])
        if funcionarioAtualmenteSwitch.isOn {
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else {
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
