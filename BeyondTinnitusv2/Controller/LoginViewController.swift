//
//  LoginViewController.swift
//  BeyondTinnitusv2
//
//  Created by Huyanh Hoang on 2016. 11. 19..
//  Copyright © 2016년 teamMedApp. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class LoginViewController: UIViewController {
    
    @IBOutlet weak var pwd: UITextField!
    @IBOutlet weak var uid: UITextField!
    fileprivate var keyboardSize: CGRect?
    fileprivate var backgroundTapGesture: UITapGestureRecognizer?
    var tone: AVAudioPlayer!
    
    
    
    @IBAction func signIn() {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "main") as? UINavigationController
            else { fatalError() }
        present(controller, animated: true, completion: nil)
        let _ = FIRDatabase.database().reference()
        FIRAuth.auth()?.signIn(withEmail: uid.text!, password: pwd.text!){ (user, error) in
            // ...
        }
    }
    
    @IBAction func playAudioFile() {
//        let path = Bundle.main.path(forResource: "Tf-8000.mp4", ofType: nil)!
//        let url = URL(fileURLWithPath: path)
        fetchFile()
    }
    
    @IBAction func playforreal() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let filePath = "\(documentsDirectory)/soundpoo.mp4"
        print("file path")
        let url = URL(fileURLWithPath: filePath)
        print(url)
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            
            tone = sound
            sound.play()
        } catch {
            // couldn't load file
            print("couldnt load file")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }
    
    func playAudioWith(file: URL) {
        do {
            let sound = try AVAudioPlayer(contentsOf: file)
            tone = sound
            tone.play()
        } catch {
            // couldn't load file
            print("couldnt load file")
        }
    }
    
    func fetchFile() {
        
        let storage = FIRStorage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference(forURL: "gs://beyondtinnitus-340f1.appspot.com")
        let soundRef = storageRef.child("soundtest.mp4")
        
        // Create local filesystem URL
//        let localURL = URL(string: "path/to/image")!
        let localURL = getDocsURL()
        
        // Download to the local filesystem
        soundRef.write(toFile: localURL) { url, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print("some error")
                print(error)
            } else {
                // Local file URL for "images/island.jpg" is returned
                print("success")
                print(url!)
                self.playAudioWith(file: url!)
            }
        }

    }
    
    func getDocsURL() -> URL {
        let filePath = "file:/sound.mp4"
        guard var docsurl = URL.init(string: filePath) else { fatalError() }
        do {
            let fm = FileManager.default
            docsurl = try fm.url(for: .documentDirectory, in: .userDomainMask,
                                     appropriateFor: nil, create: false)
            docsurl.appendPathComponent("soundpoo.mp4")
            
        } catch {
            // deal with error here
            print("error")
        }
        return docsurl
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWasShown(aNotification: NSNotification) {
        if let userInfo: NSDictionary = aNotification.userInfo! as NSDictionary? {
            keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        }
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.view.frame.origin = CGPoint(x: 0, y: -self.keyboardSize!.height)
        }, completion: nil)
    }
    
    func keyboardWillBeHidden(aNotification: NSNotification) {
        UIView.animate(withDuration: 0.1) {
            self.view.frame.origin = CGPoint(x: 0, y: 0)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        backgroundTapGesture = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(backgroundTapGesture!)
        hideKeyboardWhenTappedAround()
    }
    
    override func dismissKeyboard() {
        view.endEditing(true)
        view.removeGestureRecognizer(backgroundTapGesture!)
    }

}

