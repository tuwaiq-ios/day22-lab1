//
//  ViewController.swift
//  day-22
//
//  Created by  HANAN ASIRI on 19/03/1443 AH.
//


import UIKit



struct facts: Codable {
    var fact: String
    var length: Int
   
}



class ViewController: UIViewController {
    
    @IBOutlet var fact: UILabel!
    
    @IBOutlet var length: UILabel!
    
 
 
    override func viewDidLoad() {
        super.viewDidLoad()
        simpleGetUrlRequest()
        view.backgroundColor = UIColor(named:"Background")
       
        let tap = UITapGestureRecognizer(
        target: self, action: #selector(Changebackgroundcolor))
        
        tap.numberOfTapsRequired = 2
       view.addGestureRecognizer(tap)
       view.isUserInteractionEnabled = true
        
        let darkmood = UITapGestureRecognizer(
            target: self, action:#selector(DarkMood))
        
        darkmood.numberOfTapsRequired = 3
        view.addGestureRecognizer(darkmood)
        view.isUserInteractionEnabled = true
        view.isUserInteractionEnabled = true
        
        let swipe = UISwipeGestureRecognizer(
            target: self,
            action: #selector(swipe)
        )
        swipe.direction = .left

        view.addGestureRecognizer(swipe)
        view.isUserInteractionEnabled = true
   
    }
    @objc func Changebackgroundcolor() {
        view.backgroundColor = UIColor.green
    }
    
    @objc func DarkMood() {
        view.backgroundColor = UIColor(named: "BackgroundH")
    }
     
    @objc func swipe( ) {
        
        view.backgroundColor = UIColor(named: "BackgroundS")
        
    }
    
     @objc func simpleGetUrlRequest() {
        
   let url = URL(string: "https://catfact.ninja/fact")!

    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else { return }
        print(String(data: data, encoding: .utf8)!)
        
        let fact1 = try? JSONDecoder().decode(facts.self, from: data)
         
        
        DispatchQueue.main.async {
            self.fact.text = fact1?.fact
            self.length.text = "\(fact1!.length)"
        }
    }

    task.resume()

}
}
