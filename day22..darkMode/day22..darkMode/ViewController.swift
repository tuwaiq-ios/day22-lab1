//
//  ViewController.swift
//  day22..darkMode
//
//  Created by sara al zhrani on 19/03/1443 AH.
//

import UIKit
struct post :Codable{
    
    let name: String
    let gender: String
//   let  probability: Int
//   let count: Int
//
}



class ViewController: UIViewController {
    
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var probability: UILabel!
    @IBOutlet weak var gender: UILabel!
    override func viewDidLoad() {
           super.viewDidLoad()
        
           simpleGetUrlRequest()
           view.backgroundColor = UIColor(named: "background")
    
        let tap = UITapGestureRecognizer(target: self, action: #selector(changebackgroundcolor)
        )
        
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        
        let darkmood = UITapGestureRecognizer(target: self, action: #selector (DarkMood)
                                              )
        darkmood.numberOfTapsRequired = 3
        view.addGestureRecognizer(darkmood)
        view.isUserInteractionEnabled = true
        
        
        let swipe = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipe)
        )

        
        swipe.direction = .right
        
        
        view.addGestureRecognizer(swipe)
        
        view.isUserInteractionEnabled = true
    }
    
    @objc func changebackgroundcolor (){
        view.backgroundColor = UIColor.yellow
        
    }
    @objc func DarkMood( ){
        view.backgroundColor = UIColor(named:"backgrond1")
    }
    @objc func swipe( ){
        view.backgroundColor = UIColor(named:"background2")
    }

    func simpleGetUrlRequest( ){
    
    
        let url = URL(string:"https://api.genderize.io/?name=luc")!
    
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
    
            let post1 = try? JSONDecoder().decode(post.self, from: data)
    
            DispatchQueue.main.async {
                
                self.name.text = post1?.name
                self.gender.text = post1?.gender
//                self.count.text = "\(post1?.count)"
//                self.probability.text = "\(post1?.probability)"
               
            }
        }
            
        task.resume()
    
    
    }
   
    
    
    
}


