//
//  OptionsViewController.swift
//  TicTacToeApp
//
//  Created by Ghanavinodhini Chandrasekaran on 2020-12-15.
//

import UIKit

class OptionsViewController: ViewController {
    
    let seagueToGameVC = "seagueToGameVC"

    var computerModeGameBtn = false
    var playersModeGameBtn = false
   
    @IBOutlet weak var selectGridOptBtn: UIButton!
    
    @IBOutlet weak var computerGameOptBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Tic-Tac-Toe"
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func optionBtnClick(_ sender: UIButton) {
        
        computerModeGameBtn = false
        playersModeGameBtn = true
        
        performSegue(withIdentifier: seagueToGameVC, sender: self)
    }
    
    
    @IBAction func computerGameBtnClick(_ sender: UIButton) {
        
        computerModeGameBtn = true
        playersModeGameBtn = false
        performSegue(withIdentifier: seagueToGameVC, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == seagueToGameVC {
            
            let destinationVC = segue.destination as? GameViewController
            
            if playersModeGameBtn == true{
                destinationVC?.gameComputerMode = false
            }
            
            if playersModeGameBtn == false{
                destinationVC?.gameComputerMode = true
            }
         }
    }

}
