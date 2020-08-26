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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: #selector(promptWord))
        
        if let allWordUrl = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWord = try? String(contentsOf: allWordUrl){
                allWord = startWord.components(separatedBy: "\n");
            }
        }
        
        if allWord.isEmpty {
            allWord = ["silkWorm"]
        }
        startGame()
    
    }
    
    
    func startGame(){
        title = allWord.randomElement()
        playerWord.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerWord.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word",for: indexPath)
        cell.textLabel?.text = playerWord[indexPath.row]
        return cell
    }
    
    
    @objc func promptWord(){
        let ac = UIAlertController(title: "Enter Answere", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default){
            [weak self ,weak ac] action in
            guard let answer = ac?.textFields?[0].text else{ return }
            self.submit(answer)
        }
        
        present(ac,animated: true)
    }
    
    
    
}

 
