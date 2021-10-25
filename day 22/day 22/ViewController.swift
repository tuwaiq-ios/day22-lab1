//
//  ViewController.swift
//  day 22
//
//  Created by alanood on 19/03/1443 AH.
//

import UIKit

struct Post: Codable{
    let name:  String
    let gender: String
  
}

class ViewController: UIViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simpleGetUrlRequst()
        
           let tap = UITapGestureRecognizer(
            target: self, action: #selector(background)
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
        view.backgroundColor = UIColor(named: "background1")
        
    }
    
    @objc func swipe(){
       view.backgroundColor = UIColor(named: "background2")
    
    }
        
      @objc func simpleGetUrlRequst() {
        let url = URL(string:"https://api.genderize.io/?name=luc")!
   
        let task = URLSession.shared.dataTask (with: url){
        (data, response, error) in
        guard let data = data else {return}
        print( String(data: data, encoding: .utf8)!)
        let Post1 = try? JSONDecoder().decode(Post.self, from: data)
            
            DispatchQueue.main.async {
                self.name.text = Post1?.name
                self.gender.text = Post1?.gender
                
            }
        
    }
    task.resume()
    
        }
}

    

        
