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
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            print(response)
            
                self.news = [News]()
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: AnyObject]
                    if let newsFromJson = json["news"] as? [[String: AnyObject]] {
                        for new in newsFromJson {
                            var news = News()
                            if let title = new["title"] as? String, let author = new["author"] as? String, let description = new["description"] as? String, let url = new["url"] as? String, let image = new["image"] as? String {
                                
                                news.headLine = title
                                news.image = image
                                news.description = description
                                news.url = url
                                news.author = author
                                
                            }
                            self.news.append(news)
                        }
                    }
                    DispatchQueue.main.async {
                        self.newsTableView.reloadData()
                    }
                    
                } catch let error {
                    print(error)
                    
                }
            }
            task.resume()
        }
        
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        cell.newsTitleLabel.text = news[indexPath.row].headLine
        cell.newsDiscriptionLabel.text = news[indexPath.row].description
        cell.authorLabel.text = news[indexPath.row].author
        //cell.newsImageView.image = news[indexPath.row].image
       
        
        return cell
    }
    
   
}

