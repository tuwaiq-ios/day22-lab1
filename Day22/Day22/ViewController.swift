//
//  ViewController.swift
//  Day22
//
//  Created by Fawaz on 25/10/2021.
//

import UIKit

struct APIData: Codable{
  let name: String
  let gender: String
  let probability: Double
  let count: Int
}

class ViewController: UIViewController {
  
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var gender: UILabel!
  @IBOutlet weak var probablitity: UILabel!
  @IBOutlet weak var count: UILabel!
  
  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
  override func viewDidLoad() {
    super.viewDidLoad()
    simpleGetUrlRequset()
    
    //--------------------------------------------------------------------
    let SwipeUp = UISwipeGestureRecognizer(
      target: self,
      action: #selector(BackGroundColor1)
    )
    SwipeUp.direction = .up
    view.addGestureRecognizer(SwipeUp)
    view.isUserInteractionEnabled = true
    
    //--------------------------------------------------------------------
    let tap = UITapGestureRecognizer(
      target: self,
      action: #selector(BackGroundColor2)
    )
    tap.numberOfTapsRequired = 2
    view.addGestureRecognizer(tap)
    view.isUserInteractionEnabled = true
  }
  
  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
  @objc func BackGroundColor1(){
    view.backgroundColor = UIColor(named: "BackGround1")
  }
  @objc func BackGroundColor2(){
    view.backgroundColor = UIColor(named: "BackGround2")
  }
  
  //----------------------------------------------------------------------
  //----------------------------------------------------------------------
  
  @objc  func simpleGetUrlRequset(){
    let url = URL(string: "https://api.genderize.io/?name=luc")!
    let task = URLSession.shared.dataTask(with: url) {
      (data, response, error) in
      guard let data = data else {return}
      
      print(String(data: data , encoding: .utf8)!)
      let post = try? JSONDecoder().decode(APIData.self, from: data)
      
      DispatchQueue.main.async {
        self.name.text = post?.name
        self.gender.text = post?.gender
        self.probablitity.text = "\(post!.probability)"
        self.count.text = "\(post!.count)"
      }
    }
    task.resume()
  }
}
