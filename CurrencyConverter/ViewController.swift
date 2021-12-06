//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Nureddin Elmas on 2021-12-06.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var currecyList = [String:Any]()
    var keysC : [String] = []
    var valuesC : [Any] = []
    let url = URL(string: "http://data.fixer.io/api/latest?access_key=cb6561724dd97b7d475a7d21cadde6be")
    
    let session = URLSession.shared
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        keysC = []
        valuesC = []
        
        getData()
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
      
        cell.textLabel?.text = "EUR -> \(self.keysC[indexPath.row]) : \(self.valuesC[indexPath.row])"
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keysC.count
    }
    
    
    func getData(){
        
        //        1) Request & Session
        //        2) Response & Data
        //        3) Parsing & JSON Serialization
                
        //        1)
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=cb6561724dd97b7d475a7d21cadde6be")
        
        let session = URLSession.shared
        
        
        // Closure
        let task = session.dataTask(with: url!) { (data,response , error) in
            
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            }else {
//                2)
                if data != nil {
                    do {
                       let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        self.currecyList = (jsonResponse["rates"] as? [String:Any])!
                        self.keysC = Array(self.currecyList.keys)
                        self.valuesC = Array(self.currecyList.values)
                    } catch {
                        print("error")
                    }
                  
                   
                }
            }
        }
        task.resume()
    }
}

