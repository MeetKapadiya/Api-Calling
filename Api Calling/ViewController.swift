//
//  ViewController.swift
//  Api Calling
//
//  Created by R88 on 31/01/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usersTabelView: UITableView!
    var arrUser: [Dictionary<String, AnyObject>] = []
    var arrUsers: [User] = []
    var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getusers()
    }
    
   
    
    private func getusers(){
        guard let url = URL(string: "https://gorest.co.in/public/v2/users") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        request.addValue("application/json", forHTTPHeaderField: "Conect-Type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let apiData = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: apiData) as! [Dictionary<String, AnyObject>]
                self.arrUser = json
                DispatchQueue.main.async {
                    self.usersTabelView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
}
    
}
    
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUser.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        let rowDictionery = arrUser[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(rowDictionery["id"] as! Int)\n\(rowDictionery["name"] as! String)\n\(rowDictionery["email"] as! String)\n\(rowDictionery["gender"] as! String)"
        return cell
    }
}

class User {
    var id: Int
    var name: String
    var email: String
    var gender: String
    var stuts: String
    
    init(userDetails: Dictionary<String, AnyObject>) {
        id = userDetails["id"] as! Int
        name = userDetails["name"] as! String
        email = userDetails["email"] as! String
        gender = userDetails["gender"] as! String
        stuts = userDetails["status"] as! String
    }
}


struct Users: Decodable {
    var id: Int
    var name: String
    var email: String
    var gender: String
    var stuts: String
}


