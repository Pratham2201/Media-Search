//
//  ViewController.swift
//  FirstApplication
//
//  Created by Pratham Gupta on 07/02/23.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var segmentView: UISegmentedControl!
    
    var photos : [Photo]?
    var videos : [Video]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as? MyViewController
        
        dest?.type = segmentView.selectedSegmentIndex
        if(segmentView.selectedSegmentIndex == 0)
        {
            dest?.resultPhotos = self.photos
        }
        else
        {
            dest?.resultVideos = self.videos
        }
    }
    
    
    
    @IBAction func nextButtonClick(_ sender: Any) {
        
        if(segmentView.selectedSegmentIndex == 0)
        {
            searchPhotoAPI(query: searchBar.text!)
        }
        else
        {
            searchVideoAPI(query: searchBar.text!)
        }
    }
    
    func searchPhotoAPI(query: String) {
        if(query == "") {
            let alert = UIAlertController.init(title: "No Query Found", message: "Enter Search Query", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { _ in }))
            self.present(alert, animated: true)
        }
        else
        {
            let url: URL = URL.init(string: "https://pexelsdimasv1.p.rapidapi.com/v1/search?query=\(query)&locale=en-US&per_page=15&page=1")!
            
            var urlRequest: URLRequest = URLRequest.init(url: url)
            
            let headers = ["X-RapidAPI-Key": "6f72c444e5msh13b4a0426321d98p1140a6jsnb404800a4ee8",
            "X-RapidAPI-Host": "PexelsdimasV1.p.rapidapi.com"]
            
            urlRequest.allHTTPHeaderFields = headers
            urlRequest.httpMethod = "GET"

            let session = URLSession.shared
            let task = session.dataTask(with: urlRequest) { data, response, error in
                if(data != nil){
                    let decoder = JSONDecoder()
                    do {
                    let model =  try decoder.decode(PhotoDataModel.self, from: data!)
                        print(model.total_results!)
                        self.photos = model.photos
                        
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "testSegue", sender: nil)
                        }
                    } catch{
                        print("No data")
                    }
                }
                print(response)
                print(error ?? "No error")
            }
            
            task.resume()
        }
    }
    
    func searchVideoAPI(query: String) {
        
        
        if(query == "") {
            let alert = UIAlertController.init(title: "No Query Found", message: "Enter Search Query", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: { _ in }))
            self.present(alert, animated: true)
        }
        else
        {
            let url: URL = URL.init(string: "https://pexelsdimasv1.p.rapidapi.com/videos/search?query=\(query)&per_page=15&page=1")!
            
            var urlRequest: URLRequest = URLRequest.init(url: url)
            
            let headers = ["X-RapidAPI-Key": "6f72c444e5msh13b4a0426321d98p1140a6jsnb404800a4ee8",
            "X-RapidAPI-Host": "PexelsdimasV1.p.rapidapi.com"]
            
            urlRequest.allHTTPHeaderFields = headers
            urlRequest.httpMethod = "GET"

            let session = URLSession.shared
            let task = session.dataTask(with: urlRequest) { data, response, error in
                if(data != nil){
                    let decoder = JSONDecoder()
                    do {
                    let model =  try decoder.decode(VideoDataModel.self, from: data!)
                        print(model.total_results!)
                        self.videos = model.videos
                        
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "testSegue", sender: nil)
                        }
                    } catch{
                        print("No data")
                    }
                }
                print(response)
                print(error ?? "No error")
            }
            
            task.resume()
        }
    }
}

