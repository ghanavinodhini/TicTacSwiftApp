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
    var winPlayer  = ""
    let myColor : UIColor = UIColor.blue
    let myDefaultColor : UIColor = UIColor.white
    
    @IBOutlet weak var playerOTxtField: UITextField!
    @IBOutlet weak var playerXTxtField: UITextField!
    @IBOutlet weak var scoreOLabel: UILabel!
    @IBOutlet weak var scoreXLabel: UILabel!
    @IBOutlet weak var selectSymbolLabel: UILabel!
    
    //2D array of  subarrays
    var winRules = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]
    
    //Assign Computer Mode Symbols
    let computerSymbol = "O"
    var gameComputerMode : Bool = false
    let playerSymbol = "X"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Initialise score,textfields,animation label
        setObjectsInitialisation()
        
        //Initialise tap gestures for symbol imageviews
        symbolTapInitialise()
        
        
        //Load board initially
        loadBoard()
       
    
        //Call computerMode function if game with computer
        if(gameComputerMode == true)
        {
            playerOImageView.isUserInteractionEnabled = false
            playerOTxtField.text = "Computer"
            playerOTxtField.isEnabled = false
            print("Before calling playComputerMode function")
            playComputerMode()
        }
        if(gameComputerMode == false)
        {
            print("Inside if statement of gameComputer Mode false condition")
            playerOImageView.isUserInteractionEnabled = true
            playerOTxtField.isEnabled = true
        }
    }
    
    func setObjectsInitialisation()
    {
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
        playerXTxtField.text = nil
        playerOTxtField.text = nil
    }
    
    func symbolTapInitialise()
    {
        //Add tap gesture recogniser for 2 symbol image views
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(chooseXPlayer))     /**(chooseXPlayer(sender:) previously*/
        playerXImageView.addGestureRecognizer(tap1)
       
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(chooseOPlayer))  /**(chooseOPlayer(sender:) previously*/
        playerOImageView.addGestureRecognizer(tap2)
    }
    
    @IBAction func boxPressed(_ sender: UIButton)
    {
        if gameComputerMode == true && currentPlayer == computerSymbol
        {
            print("Inside boxPressed if conditon of gameComputerMode true")
            changeOImgColor()
            callComputerToPlay()
            return
        }
        
        
    //Check if player names are entered in textfields
        let playerTxtBool = validatePlayerTxtFields()
        
    //Get index of the button clicked
        if playerTxtBool == true
        {
        let index = boxes.firstIndex(of:sender)!
        print("Inside else part after cheking player text fields: index value,current player : \(index),\(currentPlayer)")
        
    //to avoid allowing user to change symbol inside box after one turn.
        if !board[index].isEmpty
        {
            return
        }
        
        callHumanToPlay(sender,index)
        }
        }
    
    func validatePlayerTxtFields()->Bool
    {
        if playerXTxtField.text == "" || playerOTxtField.text == ""
        {
            print("Inside checking playername text fields")
            makeLabelInvincible(msg: "Please enter Player Names")
            return false
        }else
        {
            return true
        }
    }
    
    
    func callHumanToPlay(_ sender:UIButton, _ index:Int) {
        //Check if clicked button value is 'X'
            if currentPlayer == "X"
            {
                print("Inside box pressed currentplayer X if condition")
                sender.setTitle("X", for: .normal)
                board[index] = "X"
                changeXImgColor()
                currentPlayer = "O"
                
            }
        //Check if clicked button value is 'O'
            else if currentPlayer == "O"
            {
                print("Inside box pressed currentPlayer O if condition")
                sender.setTitle("O", for: .normal)
                board[index] = "O"
                changeOImgColor()
                currentPlayer = "X"
            }
        //Check if no player selected by checking button value in grid
            else if currentPlayer == ""
            {
                print("Inside box pressed currentplayer Empty if condition")
                playerOImageView.layer.backgroundColor = myDefaultColor.cgColor
                playerXImageView.layer.backgroundColor = myDefaultColor.cgColor
                makeLabelInvincible(msg:"Tap Symbol to select Player")
            }
        //Check for winners
            winners()
        
        //Call computerPlay if game mode is with computer
        if gameComputerMode == true
        {
            callComputerToPlay()
        }
    }
    
    func callComputerToPlay()
    {
        predictMove()
        print("After calling predictMove in callComputerToPlay")
        winners()
        currentPlayer  = playerSymbol
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
    func changeOImgColor()
    {
        print("Inside change O background color")
        playerOImageView.layer.backgroundColor = myDefaultColor.cgColor
        playerXImageView.layer.backgroundColor = myColor.cgColor
    }
    
    //Change background color of symbol 'X' blue if O's turn
    func changeXImgColor()
    {
        print("Inside chage X background color")
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
            return
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
        if gameComputerMode == false
        {
        currentPlayer = ""
        }
        if gameComputerMode == true
        {
            currentPlayer = computerSymbol
           playComputerMode()
            currentPlayer = playerSymbol
        }
    }
    
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
    
    
    func playComputerMode(){
        
        print("Inside playComputerMove function")
        let randNum = Int.random(in:0...8)
        print("Random Number: \(randNum)")
        
        let index = randNum
        board[index] = "O"
        boxes[index].setTitle("O",for: .normal)
        currentPlayer = playerSymbol
    }
    
    func predictMove()
    {
        print("Inside predictMove function")
        playerXImageView.layer.backgroundColor = myColor.cgColor
        playerOImageView.layer.backgroundColor = myDefaultColor.cgColor
        for rule in winRules
        {
            let playerAt0 = board[rule[0]]
            let playerAt1 = board[rule[1]]
            let playerAt2 = board[rule[2]]
            
            print("Player position values   : \(playerAt0)-\(playerAt1)-\(playerAt2)")
            
            if playerAt0 == playerAt1 || playerAt1 == playerAt2 || playerAt0 == playerAt2
            {
                if board[rule[0]].isEmpty && currentPlayer == computerSymbol
                {
                    /************************************************************************/
                    print("board[rule[0]] value : \(board[rule[0]])")
                    print("rule[0] value : \(rule[0])")
                    print("current player : \(currentPlayer)")
                    /************************************************************************/
                    
                    let index = rule[0]
                    boxes[index].setTitle("O", for: .normal)
                    board[index] = "O"
                    //currentPlayer = playerSymbol
                    return
                }
                
                if board[rule[1]].isEmpty && currentPlayer == computerSymbol
                {
                    /************************************************************************/
                    print("board[rule[1]] value : \(board[rule[1]])")
                    print("rule[1] value : \(rule[1])")
                    print("current player : \(currentPlayer)")
                    /************************************************************************/
                    
                    let index = rule[1]
                    boxes[index].setTitle("O", for: .normal)
                    board[index] = "O"
                    //currentPlayer = playerSymbol
                    return
                }
                
                if board[rule[2]].isEmpty && currentPlayer == computerSymbol
                {
                    /************************************************************************/
                    print("board[rule[2]] value : \(board[rule[2]])")
                    print("rule[2] value : \(rule[2])")
                    print("current player : \(currentPlayer)")
                    /************************************************************************/
                    
                    let index = rule[2]
                    boxes[index].setTitle("O", for: .normal)
                    board[index] = "O"
                    //currentPlayer = playerSymbol
                    return
                }
            }
        }
    }
    
}
