//
//  ViewController.swift
//  Day22-Afnan-Lab1
//
//  Created by Fno Khalid on 19/03/1443 AH.
//

import UIKit



struct facts: Codable {
    var fact: String
    var length: Int
    
}


class ViewController: UIViewController {
   
    
    @IBOutlet weak var fact: UILabel!
    
    @IBOutlet weak var length: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        simpleGetUrlRequest()
        view.backgroundColor = UIColor(named: "background")

    
    let tap = UITapGestureRecognizer(
        target: self,
        action: #selector(Changebackgroundcolor)
       )
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        let darkmood = UITapGestureRecognizer(
            target: self,
            action: #selector(DarkMood)
            )
        
        darkmood.numberOfTapsRequired = 3
        view.addGestureRecognizer(darkmood)
        view.isUserInteractionEnabled = true
        
        
        let swiper = UISwipeGestureRecognizer(
            target: self,
            action: #selector(hundleSwipe))
      
        swiper.direction = .left
        view.addGestureRecognizer(swiper)
        view.isUserInteractionEnabled = true
    
       
    }
    
    @objc func hundleSwipe() {
        view.backgroundColor = UIColor(named: "redcolor")
    }

       @objc func Changebackgroundcolor ( ){
           view.backgroundColor = UIColor.yellow
        }
    
    @objc func DarkMood( ) {
        view.backgroundColor = UIColor(named: "background1")
        
    }

      func simpleGetUrlRequest() {
       
        let url = URL(string: "https://catfact.ninja/fact")!

        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            guard let data = data else { return }
           print(String(data: data, encoding: .utf8)!)
           let fact = try? JSONDecoder().decode(facts.self, from: data)
           
            
            
            DispatchQueue.main.async {
                
                self.fact.text = fact?.fact
                self.length.text = "\(fact!.length)"
            }
        }

        task.resume()
    }
}



