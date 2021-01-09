//
//  ViewController.swift
//  TicTacToeApp
//
//  Created by Ghanavinodhini Chandrasekaran on 2020-12-15.
//

import UIKit

class ViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create gradient background
        let newGradientLayer = CAGradientLayer()
        newGradientLayer.colors = [UIColor.white.cgColor,UIColor.systemOrange.cgColor]
        //Use same main view's frame to this layer's name
        newGradientLayer.frame = view.frame
        //Insert created layer to the back of existing layer give '0'
        view.layer.insertSublayer(newGradientLayer, at: 0)
        
    }

}

