//
//  ViewController.swift
//  SBTranslate
//
//  Created by 刘梦迪 on 2018/12/18.
//  Copyright © 2018 刘梦迪. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UITextField!
    
    let SB_WROD_QUERY_URL = "https://api.shanbay.com/bdc/search/"
    let SB_WORD_LEARNING_URL = "https://api.shanbay.com/bdc/learning/"
    
    var wordDefinition:[String:Any]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(appMovedToForerground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    @objc func appMovedToForerground() {
        let pasteboardString: String? = UIPasteboard.general.string
        if let word = pasteboardString {
            searchBar.text = word
            requestForTranslate(word: word)
        }
    }
    
    
    @IBAction func pronunce(_ sender: UIButton) {
        
        
//        if let definition = wordDefinition {
//            if let audio = definition["audio"] {
//                let url = NSURL(string: audio as! String)
//
//            }
//        }
    }
    
    func requestForTranslate(word:String) {
//        let data: [String:Any]  = ["word": word]
        
        if var urlComponents = URLComponents(string: SB_WROD_QUERY_URL) {
            urlComponents.query = "word=\(word)"
            // 3
            
            // 1
            let defaultSession = URLSession(configuration: .default)
            // 2
            var dataTask: URLSessionDataTask?
            
            guard let url = urlComponents.url else { return }
            // 4
            dataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { dataTask = nil }
                // 5
                if let error = error {
                    print(error)
//                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                        print(data)
//                    self.updateSearchResults(data)
                    // 6
                    DispatchQueue.main.async {
//                        completion(self.tracks, self.errorMessage)
                    }
                }
            }
            // 7
            dataTask?.resume()
        }
        
        
        
        
        
        
        
        
        
        
//
//
//        let config = URLSessionConfiguration.default
//        let urlString = SB_WROD_QUERY_URL + word
//        let url = URL(string: urlString)!
//        let request = URLRequest(url: url)
////        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
////        request.httpMethod = "GET"
//
//        let session = URLSession(configuration: config)
//        let task = session.dataTask(with: request) { (data,response,error) in
//            let dictionary = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//            print(dictionary!)
//
//        }
//
//        task.resume()
        
        
    }
    
    @IBAction func addCurrentWordToLearningList(_ sender: UIButton) {
        
        
    }
    

    
}

