//
//  ViewController.swift
//  WordScramble
//
//  Created by Ritik Srivastava on 26/08/20.
//  Copyright © 2020 Ritik Srivastava. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var allWord = [String]()
    var playerWord = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let allWordUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWord = try? String(contentsOf: allWordUrl){
                allWord = startWord.components(separatedBy: "\n");
            }
        }
        
        if allWord.isEmpty {
            allWord = ["silkWorm"]
        }
        
    }
    
    
    func startGame(){
        title = allWord.randomElement()
        playerWord.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }


}

 
