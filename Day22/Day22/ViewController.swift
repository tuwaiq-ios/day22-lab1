//
//  ViewController.swift
//  Day22
//
//  Created by dmdm on 25/10/2021.
//

import UIKit

struct Post: Codable {
    let name: String
    let gender: String
    let probability: Float
    let count: Int
    
}
class ViewController: UIViewController {
    
    
    @IBOutlet weak var lableName: UILabel!
    @IBOutlet weak var lableGender: UILabel!
    @IBOutlet weak var lablePro: UILabel!
    @IBOutlet weak var lableCount: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simpleGetUrlRequest()
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(Backgraound)
            )
    
        
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        
        let swipe = UISwipeGestureRecognizer (
            target: self,
            action: #selector(swipe)
            )
        swipe.direction = .right
        view.addGestureRecognizer(swipe)
        
        view.isUserInteractionEnabled = true
    }
    @objc func Backgraound()
    {
        view.backgroundColor = UIColor (named: "background1")
    }
    @objc func swipe()
    {
        view.backgroundColor = UIColor (named: "background2")
    }
    
    @objc func simpleGetUrlRequest() {
        let url = URL(string: "https://api.genderize.io/?name=luc")!
        let task = URLSession.shared.dataTask(with: url) {(data,respone,error) in
            guard let data = data else {return}
            print(String(data: data, encoding: .utf8))
            let post = try? JSONDecoder().decode(Post.self, from:data)
            
            DispatchQueue.main.async {
                
                self.lableName.text = post?.name
                self.lableGender.text = post?.gender
                self.lablePro.text = "\(post?.probability)"
                self.lableCount.text = "\(post?.count)"
            }
        }
        task.resume()
    }
}
