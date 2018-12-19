//
//  ViewController.swift
//  SBTranslate
//
//  Created by 刘梦迪 on 2018/12/18.
//  Copyright © 2018 刘梦迪. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var defintionLabel: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    let SB_WROD_QUERY_URL = "https://api.shanbay.com/bdc/search/"
    let SB_WORD_LEARNING_URL = "https://api.shanbay.com/bdc/learning/"
    
    var wordDefinition:[String:Any]? = nil
    var wordId:Int = 0
    var audioSource:String = ""
    
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var playButton:UIButton?

    
    
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
    
    @IBAction func play(_ sender: Any) {
        self.pronunce(source: self.audioSource)
    }
    
    func pronunce(source:String?) {
        let url = URL(string: self.audioSource)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem: playerItem)
        player!.play()
    }
    
    
    
    
    
    func requestForTranslate(word:String) {
        let param: [String:Any]  = ["word": word]
        AF.request(SB_WROD_QUERY_URL,method: .get,parameters: param)
            .validate()
            .responseJSON { response in
                if response.result.value != nil {
                    let body = response.result.value as! [String:Any]
                    let code = body["status_code"] as! Int
                    if code == 0 {
                        let result = body["data"] as! [String:Any]
                        let defination = result["definition"]
                        let wordId = result["id"]
                        self.wordId = wordId as! Int
                        let audioSource = result["audio"] as! String
                        self.audioSource = audioSource
                        self.pronunce(source: audioSource)
                        self.defintionLabel.text = defination as? String
                    }else {
                          self.defintionLabel.text = "没有查到这个单词"
                    }
                }
        }
    }
    
    @IBAction func addCurrentWordToLearningList(_ sender: UIButton) {
        let param:[String:Any] = [
            "id": self.wordId,
            "access_token":"FsGmwUTQO744BJCDdW6FHV9L4hM45P"
        ]
        AF.request(SB_WORD_LEARNING_URL,method: .post,parameters: param)
            .validate()
            .responseJSON { response in
                print(response)
                if response.result.value != nil {
                    let body = response.result.value as! [String:Any]
                    let code = body["status_code"] as! Int
                    
                    if code == 0 {
                        self.addBtn.isEnabled = false
                        self.addBtn.titleLabel?.text = "Done"
                    }
                }
        }
        
    }
    

    
}

