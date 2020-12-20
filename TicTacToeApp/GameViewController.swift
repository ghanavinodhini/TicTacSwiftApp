//
//  GameViewController.swift
//  TicTacToeApp
//
//  Created by Ghanavinodhini Chandrasekaran on 2020-12-15.
//

import UIKit

class GameViewController: ViewController,UITextFieldDelegate,UIGestureRecognizerDelegate{
    
    
    @IBOutlet var boxes: [UIButton]!
    
    @IBOutlet weak var playerOImageView: UIImageView!
    @IBOutlet weak var playerXImageView: UIImageView!
    var board = [String]()
    var currentPlayer = ""
    var playerXScore = 0
    var playerOScore = 0
    var winPlayer = ""
    let myColor : UIColor = UIColor.blue
    let myDefaultColor : UIColor = UIColor.white
    
    @IBOutlet weak var playerOTxtField: UITextField!
    @IBOutlet weak var playerXTxtField: UITextField!
    @IBOutlet weak var scoreOLabel: UILabel!
    @IBOutlet weak var scoreXLabel: UILabel!
    @IBOutlet weak var selectSymbolLabel: UILabel!
    
    //2D array of  subarrays
    var winRules = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide Select Symbol label initially
        self.selectSymbolLabel.isHidden = true
        
        //self.selectSymbolLabel.alpha = 0
        
       //Set border for player name textfields
        playerOTxtField.layer.borderColor = myColor.cgColor
        playerXTxtField.layer.borderColor = myColor.cgColor
        playerOTxtField.layer.borderWidth = 1.0
        playerXTxtField.layer.borderWidth = 1.0
        
        //Initialise score and player textfields
        scoreOLabel.text = "Score : \(playerOScore)"
        scoreXLabel.text = "Score : \(playerXScore)"
        playerOTxtField.text = ""
        playerOTxtField.text = ""
        
        //Load board initially
        loadBoard()
       
        //Add tap gesture recogniser for 2 symbol image views
        //let tap1 = UITapGestureRecognizer(target: self, action: #selector(chooseXPlayer(sender:)))
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(chooseXPlayer))
        playerXImageView.addGestureRecognizer(tap1)
        //let tap2 = UITapGestureRecognizer(target: self, action: #selector(chooseOPlayer(sender:)))
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(chooseOPlayer))
        playerOImageView.addGestureRecognizer(tap2)
       
    
    }
    
   
    
   /* @objc func chooseXPlayer(sender: UITapGestureRecognizer) {
     print("Inside X click")
     currentPlayer = "X"
     stopBlink(finished: true)
     playerXImageView.layer.backgroundColor = myColor.cgColor
     playerOImageView.layer.backgroundColor =  myDefaultColor.cgColor
    }
    
    @objc func chooseOPlayer(sender: UITapGestureRecognizer) {
     print("Inside O Click")
     currentPlayer = "O"
     stopBlink(finished: true)
     playerXImageView.layer.backgroundColor = myDefaultColor.cgColor
     playerOImageView.layer.backgroundColor = myColor.cgColor
    }*/
    
    @IBAction func boxPressed(_ sender: UIButton)
    {
        
            //Check if player names are entered in textfields
        if playerXTxtField.text == "" || playerOTxtField.text == ""
        {
            //showToast(message: "Please enter Player Names")
            makeLabelInvincible(msg: "Please enter Player Names")
        }
        
            //Continue game if player names are entered
        else
        {
            //Get index of the button clicked
        let index = boxes.firstIndex(of:sender)!
      
            //to avoid allowing user to change symbol inside box after one turn.
        if !board[index].isEmpty
        {
            return
        }
            //Check if clicked button value is 'X'
        if currentPlayer == "X"
        {
            sender.setTitle("X", for: .normal)
            currentPlayer = "O"
            board[index] = "X"
            disableXViews()
        }
            //Check if clicked button value is 'O'
        else if currentPlayer == "O"
        {
            sender.setTitle("O", for: .normal)
            currentPlayer = "X"
            board[index] = "O"
            disableOViews()
        }
            //Check if no player selected by checking button value in grid
        else if currentPlayer == ""
        {
            playerOImageView.layer.backgroundColor = myDefaultColor.cgColor
            playerXImageView.layer.backgroundColor = myDefaultColor.cgColor
            //makeLabelInvincible()
            makeLabelInvincible(msg:"Tap Symbol to select Player")
        }
            //Check for winners
            winners()
        
    }
    }
    
    //Change symbolselect label text and animation to visible and blink
    func makeLabelInvincible(msg:String)
    {
        self.selectSymbolLabel.text = msg
        self.selectSymbolLabel.isHidden = false
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.curveEaseInOut,.autoreverse,.repeat], animations: {self.selectSymbolLabel.alpha = 0.0},completion: stopBlink(finished:))
    }
    
    //Make symbol select label animation stop and invisible
    func stopBlink(finished:Bool){
        self.selectSymbolLabel.layer.removeAllAnimations()
        self.selectSymbolLabel.alpha = 1
        self.selectSymbolLabel.isHidden = true
    }
    
    //Change background color of symbol 'O' blue if X's turn
    func disableOViews()
    {
        print("Inside disable O views")
        playerOImageView.layer.backgroundColor = myDefaultColor.cgColor
        playerXImageView.layer.backgroundColor = myColor.cgColor
    }
    
    //Change background color of symbol 'X' blue if O's turn
    func disableXViews()
    {
        print("Inside disable X Views")
        playerXImageView.layer.backgroundColor = myDefaultColor.cgColor
        playerOImageView.layer.backgroundColor = myColor.cgColor
    }
    
    //Initialise empty value to all buttons
   func loadBoard(){
    //use '_' to use for loop without variables.
    //Use '<' to exclude  iteration of (count value-1)
    //add to an array using 'append'
    for _ in 0..<boxes.count{
            board.append("")
        }
    }
    
    //Winning logic function
    func winners()
    {
        var winMsg = ""
        for rule in winRules
        {
            let playerAt0 = board[rule[0]]
            let playerAt1 = board[rule[1]]
            let playerAt2 = board[rule[2]]
            
            print("Player position values   : \(playerAt0)-\(playerAt1)-\(playerAt2)")
            
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
               //Call Alert window with win message
                showAlert(msg: winMsg)
                return
                
            }
        }
        
        //Display Game Draw if no wins
        if !board.contains("")
        {
            showAlert(msg: "Game Draw")
            playerXImageView.layer.backgroundColor = myDefaultColor.cgColor
            playerOImageView.layer.backgroundColor = myDefaultColor.cgColor
        }
       
    }
    
    func showAlert(msg:String){
        let alert = UIAlertController(title: "Success", message: msg, preferredStyle: .alert)
        playerXImageView.layer.backgroundColor = myDefaultColor.cgColor
        playerOImageView.layer.backgroundColor = myDefaultColor.cgColor
        let action = UIAlertAction(title: "OK", style: .default){_ in
            self.resetBoard()
        }
        
        //Adding trophy in alert
        let imgTitle = UIImage(named:"trophy.png")
        let imgViewTitle = UIImageView(frame: CGRect(x: 80, y: 70, width: 150, height: 150))
        imgViewTitle.image = imgTitle
        alert.view.addSubview(imgViewTitle)
        
        
        // height constraint of Alert window
           let constraintHeight = NSLayoutConstraint(
              item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
              NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 280)
           alert.view.addConstraint(constraintHeight)

           // width constraint of Alert window
           let constraintWidth = NSLayoutConstraint(
              item: alert.view!, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute:
              NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 300)
           alert.view.addConstraint(constraintWidth)
        //print(alert.message = "Player WON : " + winPlayer)
        //alert.message = "Player WON : " + winPlayer
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //Reset board after playing game
    func resetBoard()
    {
        board.removeAll()
        loadBoard()
        
        for button in boxes{
            button.setTitle(nil, for: .normal)
        }
        currentPlayer = ""
    }
    
    //Toast message for player text fiels empty
   /* func showToast(message : String)
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
    }*/
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //self.view.endEditing(true)
        textField.resignFirstResponder()
        return false
        }
    
    //Function to stop label blink animation if player names entered
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if self.playerXTxtField.text != "" || self.playerOTxtField.text != ""
            {
                stopBlink(finished: true)
                
            }
    }
    
   /* @objc func selectPlayer(sender:UITapGestureRecognizer){
        let imageView = sender.view as? UIImageView
            if imageView != nil {
               print("Tapped image")
            }
    }*/
    
    
    @IBAction func chooseXPlayer(_ sender: UITapGestureRecognizer) {
        print("Inside X click")
        currentPlayer = "X"
        stopBlink(finished: true)
        playerXImageView.layer.backgroundColor = myColor.cgColor
        playerOImageView.layer.backgroundColor =  myDefaultColor.cgColor
        
    }
    
    @IBAction func chooseOPlayer(_ sender: UITapGestureRecognizer) {
        print("Inside O Click")
        currentPlayer = "O"
        stopBlink(finished: true)
        playerXImageView.layer.backgroundColor = myDefaultColor.cgColor
        playerOImageView.layer.backgroundColor = myColor.cgColor
    }
}
