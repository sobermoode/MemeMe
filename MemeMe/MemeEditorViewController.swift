//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Aaron Justman on 3/30/15.
//  Copyright (c) 2015 AaronJ. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController
{
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    // options for meme text
    let textFieldAttributes =
    [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont( name: "HelveticaNeue-CondensedBlack", size: 28 )!,
        NSStrokeWidthAttributeName: -4.0,
    ]
    
    // flag and vars to retain inputted meme text if the user
    // brings up the image picker and then cancels
    var oldTopText: String?
    var oldBottomText: String?
    var didCancel: Bool = false
    
    override func viewWillAppear( animated: Bool )
    {
        // set the appearance of the text fields' text
        setTextFields()
    }
    
    func setTextFields()
    {
        topText.defaultTextAttributes = textFieldAttributes
        topText.borderStyle = UITextBorderStyle.None
        topText.textAlignment = NSTextAlignment.Center
        topText.text = ( didCancel ) ? oldTopText : ""
        
        bottomText.defaultTextAttributes = textFieldAttributes
        bottomText.borderStyle = UITextBorderStyle.None
        bottomText.textAlignment = NSTextAlignment.Center
        bottomText.text = ( didCancel ) ? oldBottomText : ""
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
