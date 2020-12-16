//
//  GameViewController.swift
//  TicTacToeApp
//
//  Created by Ghanavinodhini Chandrasekaran on 2020-12-15.
//

import UIKit

class GameViewController: ViewController {
    
    
    @IBOutlet var boxes: [UIButton]!
    var board = [String]()
    var currentPlayer = ""
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBoard()
        print(board)
    
    }
    
  
    @IBAction func boxPressed(_ sender: UIButton) {
        let index = boxes.index(of:sender)!
        print(index)
        
       /* if currentPlayer == 1
        {
            sender.setImage(UIImage(named: "Cancel.png"), for: <#T##UIControl.State#>)
            currentPlayer = 2
        }
        else{
            sender.setImage(UIImage(named: "circle.png"), for: <#T##UIControl.State#>)
            currentPlayer = 1
        }*/
        
        if !board[index].isEmpty{
            return
        }
        if currentPlayer == "X"{
            sender.setTitle("X", for: .normal)
            currentPlayer = "O"
            board[index] = "X"
        }else{
            sender.setTitle("O", for: .normal)
            currentPlayer = "X"
            board[index] = "O"
        }
        
    }
    
   func loadBoard(){
        for i in 0..<boxes.count{
            board.append("")
        }
    }
}
