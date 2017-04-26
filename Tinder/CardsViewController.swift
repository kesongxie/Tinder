//
//  CardsViewController.swift
//  Tinder
//
//  Created by Xie kesong on 4/26/17.
//  Copyright © 2017 ___KesongXie___. All rights reserved.
//

import UIKit

fileprivate let segueIden = "profileSegue"

class CardsViewController: UIViewController {

    var originalCenter: CGPoint!
    
    @IBOutlet weak var pictureImageView: UIImageView!{
        didSet{
            self.pictureImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_: )))
            self.pictureImageView.addGestureRecognizer(tap)
            self.pictureImageView.frame.origin.x = (UIScreen.main.bounds.size.width - self.pictureImageView.frame.size.width) / 2
            self.originalCenter = self.pictureImageView.center
        }
    }
    
    
    @IBAction func iamgePanned(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: nil)
        switch sender.state{
        case.changed:
            var multiplier: CGFloat = -1
            if sender.location(in: nil).y < self.originalCenter.y{
                multiplier = 1
            }
            self.pictureImageView.center = CGPoint(x: self.originalCenter.x + translation.x, y: self.originalCenter.y + translation.y)
            let rotation = CGAffineTransform(rotationAngle: multiplier * translation.x / 180)
            self.pictureImageView.transform = rotation
        case .ended:
            let screenSize =  UIScreen.main.bounds.size
            if translation.x > 50 {
                let destinationCenter = CGPoint(x: 1.5 * screenSize.width, y: -0.5 * screenSize.width)
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    self.pictureImageView.center = destinationCenter
                }, completion: nil)
            }else if translation.x < -50{
                let destinationCenter = CGPoint(x: -0.5 * screenSize.width, y:  -0.5 * screenSize.width)
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    self.pictureImageView.center = destinationCenter
                }, completion: nil)
            }else{
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    self.pictureImageView.center = self.originalCenter
                    self.pictureImageView.transform = .identity
                }, completion: nil)
                print("restore")
            }
        default:
            break
        }
    }
    
    func imageTapped(_ gesture: UITapGestureRecognizer){
        self.performSegue(withIdentifier: segueIden, sender: self)
    }
    
    @IBAction func undoBtnTapped(_ sender: UIBarButtonItem) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.pictureImageView.center = self.originalCenter
            self.pictureImageView.transform = .identity
        }, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Access the ViewController that you will be transitioning too, a.k.a, the destinationViewController.
        if let destinationViewController = segue.destination as? UINavigationController{
            if let profileVC = destinationViewController.viewControllers.first as? ProfileViewController{
                profileVC.image = self.pictureImageView.image
                
                // Set the modal presentation style of your destinationViewController to be custom.
                destinationViewController.modalPresentationStyle = UIModalPresentationStyle.custom

                // Create a new instance of your fadeTransition.
                fadeTransition = FadeTransition()

                // Tell the destinationViewController's  transitioning delegate to look in fadeTransition for transition instructions.
                destinationViewController.transitioningDelegate = fadeTransition

                // Adjust the transition duration. (seconds)
                fadeTransition.duration = 1.0
            }
        }else{
            print("not working")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

