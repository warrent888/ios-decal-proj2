//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    
    @IBOutlet var stringSoFar: UILabel!
    @IBOutlet var inputLetter: UITextField!
    @IBOutlet var guessed: UILabel!
    @IBOutlet var guessButton: UIButton!
    @IBOutlet var hangmanImage: UIImageView!
    
    var hangman: Hangman!
    var wrongCounter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let b = UIBarButtonItem(title: "New Game", style: .Plain, target: self, action: "newGame:")
        self.navigationItem.rightBarButtonItem = b
        guessButton.addTarget(self, action: "guess:", forControlEvents: UIControlEvents.TouchUpInside)
        hangman = Hangman()
        initializeGame()
        hangmanImage.contentMode = .ScaleAspectFit
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeGame() {
        hangman.start()
        self.stringSoFar.text = hangman.knownString
        self.guessed.text = ""
        wrongCounter = 0
        var imageString = "hangman1"
        self.hangmanImage.image = UIImage(named: imageString)
    }
    
    func newGame(sender:UIBarButtonItem) {
        hangman.start()
        self.stringSoFar.text = hangman.knownString
        self.guessed.text = ""
        wrongCounter = 0
        var imageString = "hangman1"
        self.hangmanImage.image = UIImage(named: imageString)
    }
    
    func guess(sender:UIButton) -> Bool{
        let valid = hangman.guessLetter(inputLetter.text!)
        if (!valid) {
            wrongCounter += 1
            
            var imageString = "hangman"
            imageString += String(wrongCounter + 1)
//            imageString += ".gif"
            self.hangmanImage.image = UIImage(named: imageString)
            if (wrongCounter > 6) {
                self.hangmanImage.image = UIImage(named: "hangman7")
                let lossmessage = "the answer was: " + hangman.answer!
                let alertController = UIAlertController(title: "lolusuck!", message:
                    lossmessage, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return false
            }
            var retval = ""
            let guessedLetters = hangman.guessedLetters
            for guess in guessedLetters! {
                //                print(guess)
                retval += guess as! String
            }
            self.guessed.text = retval
            return false
        }
        else {
            if hangman.knownString == hangman.answer {
                print("you a winner")
                self.stringSoFar.text = hangman.knownString
                let alertController = UIAlertController(title: "Congratulations!", message:
                    "You won!", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return true
            }
            var retval = ""
            let guessedLetters = hangman.guessedLetters
            for guess in guessedLetters! {
                retval += guess as! String
            }
            self.guessed.text = retval
            self.stringSoFar.text = hangman.knownString
            return true
        }
    }
}

