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
    var playerXScore = 0
    var playerOScore = 0
    var winPlayer = ""
    
    //2D array of array of subarrays
    var winRules = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBoard()
       // print(board)
    
    }
    
  
    @IBAction func boxPressed(_ sender: UIButton)
    {
        let index = boxes.firstIndex(of:sender)!
      
        
        //to avoid allowing user to change symbol after one turn.
        if !board[index].isEmpty
        {
            return
        }
        if currentPlayer == "X"
        {
            sender.setTitle("X", for: .normal)
            currentPlayer = "O"
            board[index] = "X"
        }else
        {
            sender.setTitle("O", for: .normal)
            currentPlayer = "X"
            board[index] = "O"
        }
         
            winners()
        
    }
    
   func loadBoard(){
    //use '_' to use for loop without variables.
    //Use '<' to exclude  iteration of (count value-1)
    //add to an array using 'append'
    for _ in 0..<boxes.count{
            board.append("")
        }
    }
    
    func winners()
    {
        for rule in winRules
        {
            //print(rule)
        
            let playerAt0 = board[rule[0]]
            let playerAt1 = board[rule[1]]
            let playerAt2 = board[rule[2]]
            
            if playerAt0 == playerAt1,
               playerAt1 == playerAt2,
               !playerAt0.isEmpty
            {
               print("Winner inside winners function is: \(playerAt0)")
                winPlayer = playerAt0
                showAlert()
                
            }
        }
       
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Success", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default){_ in
            self.resetBoard()
        }
        print(alert.message = "Player WON : " + winPlayer)
        alert.message = "Player WON : " + winPlayer
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func resetBoard()
    {
        board.removeAll()
        loadBoard()
        
        for button in boxes{
            button.setTitle(nil, for: .normal)
        }
    }
}
