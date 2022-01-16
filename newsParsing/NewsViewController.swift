//
//  ViewController.swift
//  newsParsing
//
//  Created by Ivan Adoniev on 14.01.2022.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var newsTableView: UITableView!
    var news = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.dataSource = self
        newsTableView.delegate = self
        fetchNews()
    }

    func fetchNews() {
        guard let url = URL(string: "https://api.currentsapi.services/v1/latest-news?apiKey=8vfqS7WiOKi0VPWlccluVY57wjJlfazNlrq1HhuimQu-bcJT") else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            print(response)
            
                do {
                    let json = try JSONDecoder().decode(Response.self, from: data)
                    self.news = json.news
                    DispatchQueue.main.async {
                        self.newsTableView.reloadData()
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        .resume()
        }
        
   
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        cell.newsTitleLabel.text = news[indexPath.row].title
        cell.newsDiscriptionLabel.text = news[indexPath.row].description
        cell.authorLabel.text = news[indexPath.row].author
        guard let url = URL(string: news[indexPath.row].image ?? "") else { return cell}
        guard let imageData = try? Data(contentsOf: url) else { return cell }
        DispatchQueue.main.async {
            cell.newsImageView.image = UIImage(data: imageData)
        }
       
        return cell
       
        
      
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "seg", sender: self)
    }
   
}

    
