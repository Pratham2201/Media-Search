//
//  MyViewController.swift
//  FirstApplication
//
//  Created by Pratham Gupta on 08/02/23.
//

import UIKit

import AVKit
import AVFoundation

class MyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var resultPhotos : [Photo]? = []
    var resultVideos : [Video]? = []
    var imgResult : [UIImage?]? = []
    var type : Int?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(type == 0)
        {
            return resultPhotos!.count
        }
        else
        {
            return resultVideos!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataCell", for: indexPath) as? TestViewCellTableViewCell
        
        if(type == 0)
        {
            let obj = resultPhotos![indexPath.row]
            cell?.tvTitle.text = obj.photographer
            cell?.tvDesc.text = obj.alt
            DispatchQueue.global(qos: .utility).async {
                let img = self.getImageData(urlString: (obj.src?.tiny)!)
                print(Thread.current)
                
                DispatchQueue.main.async {
                    cell?.photoImg.image = img
                }
            }
        }
        else
        {
            let obj = resultVideos![indexPath.row]
            cell?.tvTitle.text = obj.user?.name
            cell?.tvDesc.text = obj.url
            DispatchQueue.global(qos: .utility).async {
                let img = self.getImageData(urlString: obj.image!)
                print(Thread.current)
                
                DispatchQueue.main.async {
                    cell?.photoImg.image = img
                }
            }
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewController(withIdentifier: "thirdVC") as? ThirdViewController
        
        if(type == 0)
        {
            let obj = resultPhotos![indexPath.row]
            nextViewController?.photo = obj
            self.navigationController?.pushViewController(nextViewController!, animated: true)
        }
        else
        {
            let obj = resultVideos![indexPath.row]
            let url = URL(string: obj.video_files![0].link!)!
            
            playVideo(url: url)
        }
    }
    
    func playVideo(url: URL) {
        let player = AVPlayer(url: url)
        
        let vc = AVPlayerViewController()
        vc.player = player
        
        self.present(vc, animated: true) { vc.player?.play() }
    }

    var arr : Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func getImageData(urlString: String) -> UIImage {
        let url = URL.init(string: urlString)
        do {
            let imageData = try Data.init(contentsOf: url!)
            let image = UIImage.init(data: imageData)
            return image!
        } catch {
            print("IMAGE DATA ERROR")
            return UIImage.init(named: "image")!
        }
    }
    
    //SHARED PREFERENCES IN IOS
    func saveLocal(_ lastClickedIndex: Int)
    {
        let context = UserDefaults.standard
        context.set(lastClickedIndex, forKey: "Last Selected Index")
        
        if(context.value(forKey: "Last Selected Index") != nil)
        {
            print(context.value(forKey: "Last Selected Index"))
        }
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
