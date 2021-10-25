//
//  ViewController.swift
//  Day22Gesture
//
//  Created by Tsnim Alqahtani on 19/03/1443 AH.
//


import UIKit


    struct Post: Codable {
        let name: String
        let gender: String
        let probability: Double
        let count: Int
    }
class ViewController: UIViewController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        simpleGetUrlRequset()
    //dark Mood
        //Gesture run func when tapped
        //1
        let Up = UISwipeGestureRecognizer(
            target: self,
            action: #selector(backGroundColor))
        
        Up.direction = .up
        view.addGestureRecognizer(Up)
        view.isUserInteractionEnabled = true

         
////        2
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(backGroundColor1))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)

        view.isUserInteractionEnabled = true
   }
     @objc func backGroundColor(){
       view.backgroundColor = UIColor(named: "Color")
       
   }
    @objc func backGroundColor1(){
        view.backgroundColor = UIColor(named: "Color2")

    }

    @IBOutlet weak var name1: UILabel!
    @IBOutlet weak var gender1: UILabel!
    @IBOutlet weak var probablitity1: UILabel!
    @IBOutlet weak var count1: UILabel!
    
      @objc  func simpleGetUrlRequset(){
            let url = URL(string: "https://api.genderize.io/?name=luc")!
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else {return}
                print(String(data: data , encoding: .utf8)!)
             let posts = try? JSONDecoder().decode(Post.self, from: data)

                DispatchQueue.main.async {
                    self.name1.text = posts?.name
                    self.gender1.text = posts?.gender
                    self.probablitity1.text = "\(posts!.probability)"
                    self.count1.text = "\(posts!.count)"
                    
                }
            }
          task.resume()
          
      }
}
