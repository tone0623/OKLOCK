//
//  HelpTableViewController.swift
//  enPiT2SUProduct
//
//  Created by 利根川涼介 on 2019/11/15.
//  Copyright © 2019 Jun Ohkubo. All rights reserved.
//

import UIKit


struct HelpInfo{
    var name: String
    var description: String
}

class HelpTableViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let items = [
         HelpInfo(name: "Q", description: "A"),
         HelpInfo(name: "Q", description: "A"),
         HelpInfo(name: "Q", description: "A"),
         HelpInfo(name: "Q", description: "A"),
         HelpInfo(name: "Q", description: "A")

    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "NameCell")
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let selectedRow = tableView.indexPathForSelectedRow{
            let controller = segue.destination as! HelpDetailViewController
            controller.info = items[selectedRow.row]
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
