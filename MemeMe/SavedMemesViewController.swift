//
//  SavedMemesViewController.swift
//  MemeMe
//
//  Created by Aaron Justman on 3/31/15.
//  Copyright (c) 2015 AaronJ. All rights reserved.
//

import UIKit

class SavedMemesViewController: UITabBarController {
    
    // var allMemes = [ Meme ]()
    
    override func viewWillAppear( animated: Bool )
    {
        // hide the back button
        // set the title
        // create a + button to return to the meme editor view
        self.navigationItem.setHidesBackButton( true, animated: false )
        self.navigationItem.title = "Sent Memes"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem( barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("returnToMemeEditor") )
    }
    
    func returnToMemeEditor()
    {
        self.navigationController?.popToRootViewControllerAnimated( true )
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
