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
    
    @IBOutlet var image: UIImageView!
    var img = #imageLiteral(resourceName: "yellow")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "JUMBLE GAME"
        
        image.layer.cornerRadius = 50
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptWord))
        
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
        let heading = allWord.randomElement()
        playerWord.removeAll(keepingCapacity: true)
        tableView.reloadData()
        
        let img1 = textToImage(drawText: heading!, inImage: img, atPoint: CGPoint(x: 150, y: 220))
        image.image = img1
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
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let answer = ac?.textFields?[0].text else { return }
            self?.submit(answer)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ answer:String){
        let lowerAnswer = answer.lowercased()
        
        if isPossible(word: lowerAnswer){
            if isReal(word: lowerAnswer){
                if isOriginal(word: lowerAnswer){
                    playerWord.insert(lowerAnswer, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                }
            }
        }
        
    }
    
    func isPossible(word:String)-> Bool {
        return true;
    }
    
    func isOriginal(word:String)-> Bool {
        return !allWord.contains(word);
    }
    
    func isReal(word:String)-> Bool {
        return true;
    }
    
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        
        let textColor = UIColor.black
        let textFont = UIFont(name: "Helvetica Bold", size: 160)!

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
}

 
