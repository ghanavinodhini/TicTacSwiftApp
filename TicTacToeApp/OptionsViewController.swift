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
    @IBOutlet weak var quitBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Three-In-Row"
        
        quitBtn.layer.cornerRadius = 20.0
       
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
            
            //unwrap segue destinationVC to avoid app crash if it returns nil
            if let destinationVC = segue.destination as? GameViewController{
            
            if playersModeGameBtn == true{
                destinationVC.gameComputerMode = false
            }
            
            if playersModeGameBtn == false{
                destinationVC.gameComputerMode = true
            }
         }
         }
    }
    
    
    @IBAction func quitBtnClick(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "QUIT", message: "Do You Want to Exit App?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { (_) in
            exit(0)
        }))
        
        alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
}
