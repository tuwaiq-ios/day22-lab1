//
//  ViewController.swift
//  Day22
//
//  Created by ibrahim asiri on 19/03/1443 AH.
//

import UIKit

var arrPost: Array<Post> = []

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        JsonUrl()
                
        let tab = UITapGestureRecognizer(target: self, action: #selector(color1))
        let swipeDownR = UISwipeGestureRecognizer(target: self, action: #selector(color2))
        let swipeDownL = UISwipeGestureRecognizer(target: self, action: #selector(color3))


        swipeDownR.direction = .left
        view.addGestureRecognizer(swipeDownR)
        swipeDownL.direction = .right
        view.addGestureRecognizer(swipeDownL)
        tab.numberOfTapsRequired = 2
        view.addGestureRecognizer(tab)
        
        view.isUserInteractionEnabled = true
        
    }
    @objc func color1() {
        view.backgroundColor = UIColor(named: "backgroundTap")
    }
    @objc func color2(){
        view.backgroundColor = UIColor(named: "backgroundTap2")
    }
    @objc func color3(){
        view.backgroundColor = UIColor(named: "backgroundTap3")
    }

    func JsonUrl() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let posts = try? JSONDecoder().decode([Post].self, from: data)
            
            arrPost = posts ?? []
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postA = arrPost[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostCell
    
        cell.titleLbl.text = postA.title
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}

class PostCell: UITableViewCell{
    @IBOutlet weak var titleLbl: UILabel!
}

struct Post: Codable {
    let title: String
}

