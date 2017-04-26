//
//  ProfileViewController.swift
//  Tinder
//
//  Created by Xie kesong on 4/26/17.
//  Copyright © 2017 ___KesongXie___. All rights reserved.
//

import UIKit

var fadeTransition: FadeTransition!


class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    
    var image: UIImage?
    
    @IBAction func doneBtnTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.white

        if let image = self.image{
            self.profileImageView.image = image
            let navigationBarHeight =  self.navigationController?.navigationBar.frame.size.height ?? 0
            let imageHeight = UIScreen.main.bounds.size.height - navigationBarHeight
            self.profileImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: imageHeight)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
