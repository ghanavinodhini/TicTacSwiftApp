//
//  GameViewController.swift
//  TicTacToeApp
//
//  Created by Ghanavinodhini Chandrasekaran on 2020-12-15.
//

import UIKit

class GameViewController: ViewController,UITextFieldDelegate,UIGestureRecognizerDelegate{
    
    
   // @IBOutlet var boxes: [UIButton]!
    
    @IBOutlet var boxes: [UIButton]!
    
    @IBOutlet weak var playerOImageView: UIImageView!
    @IBOutlet weak var playerXImageView: UIImageView!
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
        
        let myColor : UIColor = UIColor.blue
        playerOTxtField.layer.borderColor = myColor.cgColor
        playerXTxtField.layer.borderColor = myColor.cgColor
        
        playerOTxtField.layer.borderWidth = 1.0
        playerXTxtField.layer.borderWidth = 1.0
        
        scoreOLabel.text = "Score : \(playerOScore)"
        scoreXLabel.text = "Score : \(playerXScore)"
        playerOTxtField.text = ""
        playerOTxtField.text = ""
        loadBoard()
       
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(chooseXPlayer(sender:)))
        playerXImageView.addGestureRecognizer(tap1)
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(chooseOPlayer(sender:)))
        playerOImageView.addGestureRecognizer(tap2)
       
    
    }
    
   /* @objc func chooseXPlayer(sender: UITapGestureRecognizer) {
        print("Inside X click")
        currentPlayer = "X"
    }
    
    @objc func chooseOPlayer(sender: UITapGestureRecognizer) {
        print("Inside O click")
        currentPlayer = "O"
    }*/
    
    @IBAction func boxPressed(_ sender: UIButton) {
        
        if playerXTxtField.text == "" || playerOTxtField.text == ""
        {
            
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
        }else if currentPlayer == "O"
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
                    winMsg = "\(playerXTxtField.text ?? "Player X") WON"
                }
                if winPlayer == "O"{
                    playerOScore += 1
                    print("player O score : \(playerOScore)")
                    scoreOLabel.text = "Score : \(playerOScore)"
                    winMsg = "\(playerOTxtField.text ?? "Player O") WON"
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
        
        //Adding trophy in alert
        let imgTitle = UIImage(named:"trophy.png")
        let imgViewTitle = UIImageView(frame: CGRect(x: 80, y: 70, width: 150, height: 150))
        imgViewTitle.image = imgTitle
        alert.view.addSubview(imgViewTitle)
        
        
        // height constraint
           let constraintHeight = NSLayoutConstraint(
              item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
              NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 280)
           alert.view.addConstraint(constraintHeight)

           // width constraint
           let constraintWidth = NSLayoutConstraint(
              item: alert.view!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
              NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
           alert.view.addConstraint(constraintWidth)
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
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //self.view.endEditing(true)
        textField.resignFirstResponder()
        return false
        }
    
   /* @objc func selectPlayer(sender:UITapGestureRecognizer){
        let imageView = sender.view as? UIImageView
            if imageView != nil {
               print("Tapped image")
            }
    }*/
    
    
    @IBAction func chooseXPlayer(sender: UITapGestureRecognizer) {
        print("Inside X click")
        currentPlayer = "X"
    }
    
    @IBAction func chooseOPlayer(sender: UITapGestureRecognizer) {
        
        print("Inside O Click")
        
        currentPlayer = "O"
    }
    
   
    
}
