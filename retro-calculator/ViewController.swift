//
//  ViewController.swift
//  retro-calculator
//
//  Created by Jonathan Wood on 9/4/15.
//  Copyright © 2015 Jonathan Wood. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    //Properties
    var runningNum: String = ""
    var rightValString: String = ""
    var leftValString: String = ""
    var currentOperation: Operation = Operation.Empty
    var result: String = ""
    
    enum Operation: String {
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        case Empty = "Empty"
    }
    
    
    // Sound on load
    var btnSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("retroBtn", ofType: "mp3")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    
    //Outlets
    @IBOutlet weak var displayLabel: UILabel!
    
    
    //Actions
    @IBAction func numberPressed(btn: UIButton) {
        playSound()
        
        runningNum += "\(btn.tag)"
        displayLabel.text = runningNum
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    
    //Functions
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            // run some math
            
            //A user selected an operator, but then selected another operator without
            //first entering a number...
            if runningNum != "" {
                rightValString = runningNum
                runningNum = ""
                
                if currentOperation == Operation.Add {
                    result = "\(Double(leftValString)! + Double(rightValString)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValString)! - Double(rightValString)!)"
                } else if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValString)! * Double(rightValString)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValString)! / Double(rightValString)!)"
                    displayLabel.text = runningNum
                }
                
                leftValString = result
                displayLabel.text = result
            }
            
            currentOperation = op
            
        } else {
            // This is the first time an operator has been pressed
            leftValString = runningNum
            runningNum = ""
            currentOperation = op
        }
    }
    
    



}

