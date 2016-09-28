//
//  GameOverVC.swift
//  pathFinder
//
//  Created by AW on 20/09/2016.
//  Copyright © 2016 Allan Wallace. All rights reserved.
//

import UIKit

class GameOverVC: UIViewController{

    
    @IBOutlet weak var newGameBtn: UIButton!
    @IBOutlet weak var HSLblV2: UILabel!
    let SHADOW_COLOUR: CGFloat = 157.0 / 255.0
    var highscore = Int()
    var highscore2 = Int()
    var highscore3 = Int()
    var highscore4 = Int()
    var highscore5 = Int()
    var highscore6 = Int()
    var score = Int()
    var newScore = Int()
    var colourScheme = String()
    
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var Label2: UILabel!
    @IBOutlet weak var Label3: UILabel!
    @IBOutlet weak var Label4: UILabel!
    @IBOutlet weak var Label5: UILabel!
    @IBOutlet weak var messageLBL: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var finalScoreLbl: UILabel!
    
    @IBOutlet weak var topView: UIView!
    override func viewDidLoad() {
        
        
        
        scoreView.layer.cornerRadius = 12.0
        scoreView.layer.shadowRadius = 12.0
        scoreView.layer.shadowOpacity = 0.8
       
        scoreView.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        
        newGameBtn.layer.cornerRadius = 6.0
        newGameBtn.layer.shadowRadius = 6.0
        newGameBtn.layer.shadowOpacity = 0.8
        
        newGameBtn.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        
        
        let colourSchemeChoice = UserDefaults.standard
        
        if colourSchemeChoice.string(forKey: "chosenColourScheme") == nil {
            colourScheme = "blue"
        } else {
            colourScheme = colourSchemeChoice.string(forKey: "chosenColourScheme")!
        }
        
        if colourScheme == "pink" {
            topView.backgroundColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            bottomView.backgroundColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            newGameBtn.backgroundColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            scoreView.backgroundColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            messageLBL.textColor = UIColor(red: 0.5647, green: 0.7921, blue: 0.9765, alpha: 1.0)
            
        } else if colourScheme == "blue" {
            topView.backgroundColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            bottomView.backgroundColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            newGameBtn.backgroundColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            scoreView.backgroundColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            messageLBL.textColor = UIColor(red: 1.0, green: 0.502, blue: 0.051, alpha: 1.0 )
        }  else if colourScheme == "random" {
            scoreView.backgroundColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            messageLBL.textColor = UIColor(red: 1.0, green: 0.502, blue: 0.051, alpha: 1.0 )
            topView.backgroundColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            newGameBtn.backgroundColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0)
            bottomView.backgroundColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            
        }
        
        
        let scoreDefault2 = UserDefaults.standard
        let scoreDefault3 = UserDefaults.standard
        let scoreDefault4 = UserDefaults.standard
        let scoreDefault5 = UserDefaults.standard
        let scoreDefault6 = UserDefaults.standard
        let finalScore = UserDefaults.standard
        
        
        if finalScore.integer(forKey: "finalScore") != 0{
            
            score = finalScore.integer(forKey: "finalScore")
        }
        else{
            
            score = 0
        }
        
        
        if scoreDefault6.integer(forKey: "savedHighScore6") != 0{
            
            highscore6 = scoreDefault6.integer(forKey: "savedHighScore6")
        }
        else{
            
            highscore6 = 0
        }
        
        
        if scoreDefault2.integer(forKey: "savedHighScore2") != 0{
            
            highscore2 = scoreDefault2.integer(forKey: "savedHighScore2")
        }
        else{
            
            highscore2 = 0
        }
    
        if scoreDefault3.integer(forKey: "savedHighScore3") != 0{
            
            highscore3 = scoreDefault3.integer(forKey: "savedHighScore3")
        }
        else{
            
            highscore3 = 0
        }
        
        if scoreDefault4.integer(forKey: "savedHighScore4") != 0{
            
            highscore4 = scoreDefault4.integer(forKey: "savedHighScore4")
        }
        else{
            
            highscore4 = 0
        }
        
        if scoreDefault5.integer(forKey: "savedHighScore5") != 0{
            
            highscore5 = scoreDefault5.integer(forKey: "savedHighScore5")
        }
        else{
            
            highscore5 = 0
        }

        
        if score == highscore2 {
            newScore = 1
        
        } else if score == highscore3 {
            newScore = 2
            
        } else if score == highscore4 {
            newScore = 3
        } else if score == highscore5 {
            newScore = 4
        } else if score == highscore6 {
            newScore = 5
        } else {
            
        newScore = 0
        
        }
        
        
        
        if newScore == 1 {
        
        Label1.font = UIFont.boldSystemFont(ofSize: 19)
            
            messageLBL.text = "New Champion!"
            
        
        } else if newScore == 2{
            Label2.font = UIFont.boldSystemFont(ofSize: 19)
            messageLBL.text = "New 2nd Place Score"
            
        } else if newScore == 3 {
            Label3.font = UIFont.boldSystemFont(ofSize: 19)
            messageLBL.text = "New 3rd Place Score"
        } else if newScore == 4 {
            Label4.font = UIFont.boldSystemFont(ofSize: 19)
            messageLBL.text = "New 4th Place Score"
            
        } else if newScore == 5 {
            Label5.font = UIFont.boldSystemFont(ofSize: 19)
            messageLBL.text = "New 5th Place Score"
        } else {
            messageLBL.text = "Better luck next time!"
        }
            
            
        Label1.text = "\(highscore2)"
        Label2.text = "\(highscore3)"
        Label3.text = "\(highscore4)"
        Label4.text = "\(highscore5)"
        Label5.text = "\(highscore6)"
        finalScoreLbl.text = "\(score)"
        
        score = 0
        finalScore.set(score, forKey: "finalScore")
        
        
        
    }
    
    
    @IBAction func NewGameBtnPressed(_ sender: AnyObject) {
        self.performSegue(withIdentifier: "back", sender: nil)
        
    }
    
}


