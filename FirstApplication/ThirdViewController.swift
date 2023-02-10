//
//  ThirdViewController.swift
//  FirstApplication
//
//  Created by Pratham Gupta on 08/02/23.
//
import UIKit
import AVKit
import AVFoundation

class ThirdViewController: UIViewController {
    
    var photo : Photo!
    @IBOutlet weak var ivSelectedImage: UIImageView!
    
    var thirdArr : Array<String>?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadImage()
//        DatabaseManager.shared.savePhoto(photo: photo)
//        DatabaseManager.shared.getData()
    }
    
    func downloadImage()
    {
        let url = URL.init(string: (photo?.src?.original)!)!
        let session = URLSession.shared
        let task = session.downloadTask(with: url) { url, response, error in
            do {
                let data = try Data.init(contentsOf: url!)
                print(data)
                
                DispatchQueue.main.async {
                    self.ivSelectedImage.image = UIImage.init(data: data)
                }
            }
            catch{
                print("No data")
            }
        }
        task.resume()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
