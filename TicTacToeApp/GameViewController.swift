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
    
    @IBOutlet weak var playerOTxtField: UITextField!
    @IBOutlet weak var playerXTxtField: UITextField!
    @IBOutlet weak var scoreOLabel: UILabel!
    @IBOutlet weak var scoreXLabel: UILabel!
    
    //2D array of array of subarrays
    var winRules = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreOLabel.text = "Score : \(playerOScore)"
        scoreXLabel.text = "Score : \(playerXScore)"
        loadBoard()
        
       // print(board)
    
    }
    
   
  
    @IBAction func boxPressed(_ sender: UIButton)
    {
        if playerXTxtField.text == "" || playerOTxtField.text == ""{
            
            showToast(message: "Please enter Player Names")
        }else{
            
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
        var winMsg = ""
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
                if winPlayer == "X"{
                    playerXScore += 1
                    print("player X score: \(playerXScore)")
                    scoreXLabel.text = "Score : \(playerXScore)"
                    winMsg = "\(String(describing: playerXTxtField.text)) WON"
                }
                if winPlayer == "O"{
                    playerOScore += 1
                    print("player O score : \(playerOScore)")
                    scoreOLabel.text = "Score : \(playerOScore)"
                    winMsg = "\(String(describing: playerOTxtField.text)) WON"
                }
               // showAlert(msg:"Player WON: \(winPlayer)" )
                showAlert(msg: winMsg)
                return
                
            }
        }
        
        //Display Game Draw if no wins
        if !board.contains("")
        {
            showAlert(msg: "Game Draw")
        }
       
    }
    
    func showAlert(msg:String){
        let alert = UIAlertController(title: "Success", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default){_ in
            self.resetBoard()
        }
        //print(alert.message = "Player WON : " + winPlayer)
        //alert.message = "Player WON : " + winPlayer
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
    
    func showToast(message : String)
    {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 175, y: self.view.frame.size.height-100, width: 350, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
