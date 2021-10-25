//
//  ViewController.swift
//  task22 new
//
//   Created by PC on 19/03/1443 AH.
//

import UIKit
struct post : Codable {
    let id: Int
    let description: String
    let category: String
}
class ViewController: UIViewController {
    @IBOutlet weak var id1: UILabel!
    @IBOutlet weak var description1: UILabel!
    @IBOutlet weak var category1: UILabel!
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
    @objc func background ()
    {
        view.backgroundColor = UIColor (named: "background1")
    }
    @objc func swipe (){
        view.backgroundColor = UIColor (named: "background2")
        
        
    }
    @objc func simpleGetUrlRequest() {
        
       let url = URL(string: "https://fakestoreapi.com/products/1")!
       let task = URLSession.shared.dataTask(with: url) {(data,respone,error) in
           guard let data = data else {return}
            print(String(data: data, encoding: .utf8))
           let post = try? JSONDecoder().decode(post.self, from:data)
            DispatchQueue.main.async {
             self.id1.text = "\(post?.id)"
               self.description1.text = post?.description
               self.category1.text = post?.category
            }
        }
        task.resume()
    }
}
