//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Aaron Justman on 3/30/15.
//  Copyright (c) 2015 AaronJ. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate
{
    // ACTION/CANCEL button outlets
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    // meme'd image outlet
    @IBOutlet weak var memeImageView: UIImageView!
    
    // meme text field outlets
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    // image selection button outlets
    @IBOutlet weak var pickFromCameraButton: UIBarButtonItem!
    @IBOutlet weak var pickFromAlbumButton: UIBarButtonItem!
    
    // options for meme text
    let textFieldAttributes =
    [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont( name: "HelveticaNeue-CondensedBlack", size: 28 )!,
        NSStrokeWidthAttributeName: -4.0,
    ]
    
    // flag to hide text fields before an image is picked
    var isFirstTime: Bool = true
    
    // flag and vars to retain inputted meme text if the user
    // brings up the image picker and then cancels
    var oldTopText: String?
    var oldBottomText: String?
    var didCancel: Bool = false
    
    override func viewWillAppear( animated: Bool )
    {
        // disable camera button if the device doesn't have a camera
        pickFromCameraButton.enabled = UIImagePickerController.isSourceTypeAvailable( .Camera )
        
        // hide the text fields before the user picks the first image;
        // disable the ACTION button if the user hasn't meme'd an image
        if( isFirstTime )
        {
            topText.hidden = true
            bottomText.hidden = true
            actionButton.enabled = false
            cancelButton.enabled = false
        }
        
        // set the appearance of the text fields' text
        setTextFields()
        
        // subscribe to keyboard notifications
//        NSNotificationCenter.defaultCenter().addObserver(
//            self,
//            selector: "shiftFrameUp:",
//            name: UIKeyboardWillShowNotification,
//            object: nil )
//        
//        NSNotificationCenter.defaultCenter().addObserver(
//            self,
//            selector: "shiftFrameDown:",
//            name: UIKeyboardWillHideNotification,
//            object: nil )
    }
    
//    override func viewWillDisappear( animated: Bool )
//    {
//        NSNotificationCenter.defaultCenter().removeObserver(
//            self,
//            name: UIKeyboardWillShowNotification,
//            object: nil )
//        NSNotificationCenter.defaultCenter().removeObserver(
//            self,
//            name: UIKeyboardWillHideNotification,
//            object: nil )
//        
//        // NSNotificationCenter.defaultCenter().removeObserver( self )
//    }
    
    func setTextFields()
    {
        topText.defaultTextAttributes = textFieldAttributes
        topText.borderStyle = UITextBorderStyle.None
        topText.textAlignment = NSTextAlignment.Center
        bottomText.defaultTextAttributes = textFieldAttributes
        bottomText.borderStyle = UITextBorderStyle.None
        bottomText.textAlignment = NSTextAlignment.Center
        
        // retain meme text if the user canceled an image picking operation
        topText.text = ( didCancel ) ? oldTopText : "TOP"
        bottomText.text = ( didCancel ) ? oldBottomText : "BOTTOM"
    }
    
    // the user can take a picture using the camera or
    // pick an image already in their photo library to meme-ify
    // NOTE: developed on a macbook; there is no camera.
    // the camera button is always disabled and i have not tested
    // actual picture-taking functionality.
    @IBAction func takeOrPickImage( sender: UIBarButtonItem )
    {
        // copy any already-inputted text so it will still be there
        // if the user cancels the picking operation
        oldTopText = topText.text?
        oldBottomText = bottomText.text?
        
        let pickerController = UIImagePickerController()
        
        pickerController.delegate = self
        pickerController.sourceType = ( sender.tag == 1 ) ? .Camera : .PhotoLibrary
        
        self.presentViewController( pickerController, animated: true, completion: nil )
    }
    
    func imagePickerController( picker: UIImagePickerController!,
                                didFinishPickingImage image: UIImage!,
                                editingInfo: [NSObject : AnyObject]! )
    {
        memeImageView.image = image
        
        // show the text fields so the user can enter meme text;
        topText.hidden = false
        bottomText.hidden = false
        
        // enable the ACTION and CANCEL buttons
        actionButton.enabled = true
        cancelButton.enabled = true
        
        // no longer coming to the view controller for the first time;
        // the user picked an image and didn't cancel the image picking operation
        isFirstTime = false
        didCancel = false
        
        // dismiss the image picker
        dismissViewControllerAnimated( true, completion: nil )
    }
    
    func imagePickerControllerDidCancel( picker: UIImagePickerController )
    {
        // set the cancel flag, so that the previously entered meme text
        // will remain with the previously picked image
        didCancel = true
        
        dismissViewControllerAnimated( true, completion: nil )
    }
    
    // when the user begins entering some meme text,
    // blank out the extisting "TOP" or "BOTTOM" placeholder
    func textFieldDidBeginEditing( textField: UITextField )
    {
        textField.text = ""
    }
    
    // TODO: these functions are being called multiple times.
    // Figure out why. Figure out why the simulatio keyboard
    // doesn't always appear when editing a text field.
    
    // shift the view so the keyboard doesn't obscure the image
    func shiftFrameUp( notification: NSNotification )
    {
        println( "Shifting frame up..." )
        if( bottomText.editing )
        {
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![ UIKeyboardFrameEndUserInfoKey ] as NSValue
            self.view.frame.origin.y -= keyboardSize.CGRectValue().height
        }
    }
    
    // reset the view
    func shiftFrameDown( notification: NSNotification )
    {
        println( "Shifting frame down..." )
        if( bottomText.editing )
        {
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![ UIKeyboardFrameEndUserInfoKey ] as NSValue
            self.view.frame.origin.y += keyboardSize.CGRectValue().height
        }
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
