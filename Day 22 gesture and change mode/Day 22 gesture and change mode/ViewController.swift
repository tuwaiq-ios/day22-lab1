//
//  ViewController.swift
//  Day 22 gesture and change mode
//
//  Created by Eth Os on 19/03/1443 AH.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var testImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(named: "Background")
        
        let DarkTap = UITapGestureRecognizer(target: self,
                                         action: #selector(whenScreenDark))
        DarkTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(DarkTap)
        
        let LightTap = UITapGestureRecognizer(target: self,
                                              action: #selector(whenScreenLight))
        LightTap.numberOfTapsRequired = 2
             view.addGestureRecognizer(LightTap)
        
        let swip = UISwipeGestureRecognizer(target: self, action: #selector(changeColor))
        swip.direction = .right
        view.addGestureRecognizer(swip)
        
        getImageAPI()
    }
    @objc func changeColor(){
        view.backgroundColor = .red
    }
   @objc func whenScreenLight(){
       view.backgroundColor = UIColor(named: "newBackground")
    }
    
   @objc func whenScreenDark(){
       view.backgroundColor = UIColor(named: "newBackground")
    }
    
    func getImageAPI(){
        let url = URL(string: "https://hub.dummyapis.com/image?text=Test&height=120&width=120")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else {
                print("no data, or there was an error")
                return
            }
            let downloadImage = UIImage(data: data)
            DispatchQueue.main.async {
                self.testImageView.image = downloadImage
            }
        }

        task.resume()
        
    }
}
