//
//  CreditsViewController.swift
//  Pokedex
//
//  Created by emersonmalca on 7/27/16.
//  Copyright © 2016 Emerson Malca. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstName.alpha = 0.0
        lastName.alpha = 0.0
        
        let done = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(doneTapped))
        navigationItem.setRightBarButtonItem(done, animated: true)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.3, animations: {
            self.imageView.alpha = 0.5
        })
        
        UIView.animateWithDuration(0.3, delay: 0.1, options: [], animations: { () -> Void in
            self.firstName.alpha = 1.0
        }, completion: nil)
        
        UIView.animateWithDuration(0.3, delay: 0.2, options: [], animations: { () -> Void in
            self.lastName.alpha = 1.0
        }, completion: nil)
    }
    

    func doneTapped() {
        // TODO: Delegation
        dismissViewControllerAnimated(true, completion: nil)
    }

}
