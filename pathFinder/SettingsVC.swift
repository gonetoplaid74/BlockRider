//
//  SettingsVC.swift
//  pathFinder
//
//  Created by AW on 23/09/2016.
//  Copyright © 2016 Allan Wallace. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var soundFXLbl: UILabel!
    
    @IBOutlet weak var diffLbl: UILabel!
    @IBOutlet weak var colourLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var colourChoose: UISegmentedControl!
    @IBOutlet weak var diffChoose: UISegmentedControl!
    
    @IBOutlet weak var kidsBtn: UISwitch!
    @IBOutlet weak var kidsLbl: UILabel!
    @IBOutlet weak var holdLbl: UILabel!
    @IBOutlet weak var soundOff: UISwitch!
    @IBOutlet weak var bottomBar: UIView!
    
    var kidsModeOn = "off"
    var speed = Int()
    var colour = String()
    var colourScheme = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let colourSchemeChoice = UserDefaults.standard
        let diffChosen = UserDefaults.standard
        let kidsMode = UserDefaults.standard
        
        if kidsMode.string(forKey: "kidsMode") == nil {
            kidsBtn.isOn = false
        } else {
        
        kidsModeOn = kidsMode.object(forKey: "kidsMode") as! String
        }
        if kidsModeOn == "on" {
            kidsBtn.isOn = true
        } else {
            kidsBtn.isOn = false
        }
        
        if diffChosen.integer(forKey: "startingSpeed") == 0 {
            speed = -60
            
        } else {
            speed = diffChosen.integer(forKey: "startingSpeed")
        }
      
        if speed == -60 {
            diffChoose.selectedSegmentIndex = 0
        } else if speed == -80 {
            diffChoose.selectedSegmentIndex = 1
        } else if speed == -110 {
            diffChoose.selectedSegmentIndex = 2
        }
        
        if colourSchemeChoice.string(forKey: "chosenColourScheme") == nil {
            colourScheme = "blue"
        } else {
            colourScheme = colourSchemeChoice.string(forKey: "chosenColourScheme")!
        }
        
        doneBtn.layer.cornerRadius = 6.0
        doneBtn.layer.shadowRadius = 6.0
        doneBtn.layer.shadowOpacity = 0.8
        doneBtn.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)

        if colourScheme == "pink" {
            topBar.backgroundColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            doneBtn.backgroundColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            titleLbl.textColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            diffLbl.textColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            colourLbl.textColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            soundFXLbl.textColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            colourChoose.tintColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            diffChoose.tintColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            holdLbl.textColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            soundOff.onTintColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            bottomBar.backgroundColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            kidsLbl.textColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            kidsBtn.onTintColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            kidsBtn.tintColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            colourChoose.selectedSegmentIndex = 1
            
            
        } else if colourScheme == "blue" {
            topBar.backgroundColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            doneBtn.backgroundColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            titleLbl.textColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            diffLbl.textColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            colourLbl.textColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            soundFXLbl.textColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            colourChoose.tintColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            diffChoose.tintColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            holdLbl.textColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            soundOff.onTintColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            bottomBar.backgroundColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            kidsLbl.textColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            kidsBtn.onTintColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            kidsBtn.tintColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            
            colourChoose.selectedSegmentIndex = 0
        
        }  else if colourScheme == "random" {
            topBar.backgroundColor = UIColor(red: 1.0, green: 0.502, blue: 0.051, alpha: 1.0 )
            doneBtn.backgroundColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            titleLbl.textColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            diffLbl.textColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            colourLbl.textColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            soundFXLbl.textColor = UIColor(red: 1.0, green: 0.502, blue: 0.051, alpha: 1.0 )
            colourChoose.tintColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            diffChoose.tintColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            holdLbl.textColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            soundOff.onTintColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            bottomBar.backgroundColor = UIColor(red: 1.0, green: 0.502, blue: 0.051, alpha: 1.0 )
            kidsLbl.textColor = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            kidsBtn.onTintColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            kidsBtn.tintColor = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            colourChoose.selectedSegmentIndex = 2

        }
        
                
    }

    @IBAction func colourSelector(_ sender: AnyObject) {
        let storeColour = UserDefaults.standard
        
    
        
        
        if colourChoose.selectedSegmentIndex == 0 {
            colour = "blue"
            storeColour.set(colour, forKey: "chosenColourScheme")
            
            
        } else if colourChoose.selectedSegmentIndex == 1 {
         colour = "pink"
            storeColour.set(colour, forKey: "chosenColourScheme")
            
            
        } else if colourChoose.selectedSegmentIndex == 2 {
            colour = "random"
            storeColour.set(colour, forKey: "chosenColourScheme")
            
            
            
        }
        
        colourScheme = colour
        
        
    viewDidLoad()
    
    
    
    }
    
    
    @IBAction func diffChooseBtn(_ sender: AnyObject) {
        
        let chosenDiff = UserDefaults.standard
        
        if diffChoose.selectedSegmentIndex == 0{
            speed = -60
            
        } else if diffChoose.selectedSegmentIndex == 1 {
            speed = -80
        } else if diffChoose.selectedSegmentIndex == 2 {
            speed = -110
        }
        
        chosenDiff.set(speed, forKey: "startingSpeed")
    }
    
  
    @IBAction func kidsModSlider(_ sender: AnyObject) {
        
        let kidsMode = UserDefaults.standard
        
        
        if kidsBtn.isOn == true {
            kidsModeOn = "on"
        } else {
            kidsModeOn = "off"
        }
        
        kidsMode.set(kidsModeOn, forKey: "kidsMode")
    
        
        
        
    }
    
    


}
