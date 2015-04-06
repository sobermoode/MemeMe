//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Aaron Justman on 4/2/15.
//  Copyright (c) 2015 AaronJ. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    @IBOutlet weak var memeImageView: UIImageView!
    
    // this var holds the image set in SavedMemesCollectionViewCotroller's
    // prepareForSegue()
    var memedImage: UIImage!
    
    // set the image view's image property using the holder var
    override func viewWillAppear( animated: Bool )
    {
        memeImageView.image = memedImage
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
