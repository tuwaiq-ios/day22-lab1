//
//  ViewController.swift
//  Day22
//
//  Created by Sara M on 19/03/1443 AH.
//

import UIKit


struct Post: Codable {
    
    let name: String
    let gender: String
    let probability: Double
    let count: Int
    
}
class ViewController: UIViewController{
    
    
    @IBOutlet weak var NameVC: UILabel!
    @IBOutlet weak var GenderVC: UILabel!
    @IBOutlet weak var ProbabilitytVC: UILabel!
    @IBOutlet weak var CountVC: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simpleGetUrlRequest()
        
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(background)
        )
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
                
        let swipe = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipe)
        )
        swipe.direction = .right
        view.addGestureRecognizer(swipe)
        
        view.isUserInteractionEnabled = true
    }
    
    @objc func background()
    {
        view.backgroundColor = UIColor (named: "background1")
        
    }
    @objc func swipe() {
        view.backgroundColor = UIColor (named: "background2")
        
    }
    @objc func simpleGetUrlRequest() {
        let url = URL(string: "https://api.genderize.io?name=luc")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8))
            let posts = try? JSONDecoder().decode(Post.self, from: data)
            
            
            DispatchQueue.main.async {
                self.NameVC.text = posts?.name
                self.GenderVC.text = posts?.gender
                self.ProbabilitytVC.text = "\(posts?.probability)"
                self.CountVC.text = "\(posts?.count)"
                
            }
            
        }
        
        task.resume()
    }
    
}
