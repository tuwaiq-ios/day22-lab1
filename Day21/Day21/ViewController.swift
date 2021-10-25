
import UIKit

var pp = [Post] ()
struct Post: Codable {
    
    let id: Int
    let title: String
    let description: String

}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        
        let p = pp[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! tvCell
        
        
        cell.label1.text = "\(p.id)"
        cell.label2.text = p.title
        cell.label3.text = p.description
        
        return cell
    }
    

    @IBOutlet weak var TV: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        TV.delegate = self
        TV.dataSource = self
       
        view.backgroundColor = UIColor(named: "background")
        simpleGetUrlRequest()
        
        

        let tap = UISwipeGestureRecognizer(
            target: self,
            action: #selector(changeBackground)
        )
        
        tap.direction = .right
            view.addGestureRecognizer(tap)
        
        
        
        let tap1 = UITapGestureRecognizer(
            target: self,
            action: #selector(changeColor)
        )


            tap1.numberOfTapsRequired = 2
            view.addGestureRecognizer(tap1)
        
        
        
            view.isUserInteractionEnabled = true

        simpleGetUrlRequest()
       
    }
  
    @objc func changeBackground() {
        
        view.backgroundColor = UIColor(named: "Color")
        
    }
    
    @objc func changeColor() {
        
        view.backgroundColor = UIColor.systemOrange
        
    }
    

    
   @objc func  simpleGetUrlRequest() {
        let url = URL(string:
                        "https://fakestoreapi.com/products")!
  
        let task = URLSession.shared.dataTask(with: url){
            (data, response, error) in
        guard let data = data else { return }
        let posts = try? JSONDecoder().decode([Post].self, from: data)
        pp = posts ?? []
            
            
            
            DispatchQueue.main.async {
                self.TV.reloadData()
            }
            
        }

        task.resume()
        
    }
    
    
    
    


}

