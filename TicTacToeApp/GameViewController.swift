//
//  GameViewController.swift
//  TicTacToeApp
//
//  Created by Ghanavinodhini Chandrasekaran on 2020-12-15.
//

import UIKit

class GameViewController: ViewController {
    
    
    @IBOutlet weak var player1TxtField: UITextField!
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2TxtField: UITextField!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    
    @IBOutlet weak var box1: UIButton!
    @IBOutlet weak var box2: UIButton!
    @IBOutlet weak var box3: UIButton!
    @IBOutlet weak var box4: UIButton!
    @IBOutlet weak var box5: UIButton!
    @IBOutlet weak var box6: UIButton!
    @IBOutlet weak var box7: UIButton!
    @IBOutlet weak var box8: UIButton!
    @IBOutlet weak var box9: UIButton!
    
    var currentPlayer = 1 //Cross
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    @IBAction func player2TxtField(_ sender: UITextField) {
    }
    
    @IBAction func player1TxtField(_ sender: UITextField) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
