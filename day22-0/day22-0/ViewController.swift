//
//  ViewController.swift
//  day22-0
//
//  Created by Hassan Yahya on 19/03/1443 AH.
//

import UIKit

struct Post : Codable{
    let name : String
    let gender : String
    let probability : Double
    let count: Int
}
class ViewController: UIViewController {
    @IBOutlet weak var nameVC: UILabel!
    @IBOutlet weak var genderVC: UILabel!
    @IBOutlet weak var PVC: UILabel!
    @IBOutlet weak var countVC: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simpleGetUrlRequest()
        let tap = UITapGestureRecognizer(target: self,
        action: #selector(background)
        )
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe)
        )
        swipe.direction = .right
        view.addGestureRecognizer(swipe)
        view.isUserInteractionEnabled = true
    }
    @objc func background(){
        view.backgroundColor = UIColor (named: "background1")
    }
    @objc func swipe(){
        view.backgroundColor = UIColor (named: "background2")
    }
    @objc func simpleGetUrlRequest(){
        
        let url = URL(string: "https://api.genderize.io?name=luc")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data :data ,encoding: .utf8))
            let posts = try? JSONDecoder().decode(Post.self, from: data)
            
            DispatchQueue.main.async {
                self.nameVC.text = posts?.name
                self.genderVC.text = posts?.gender
                self.PVC.text = "\(posts?.probability)"
                self.countVC.text = "\(posts?.count)"
                
            }
        }
        
        task.resume()
    }
}


