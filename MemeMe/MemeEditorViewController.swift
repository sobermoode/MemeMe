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
    
    // toolbar and image selection button outlets
    @IBOutlet weak var bottomToolbar: UIToolbar!
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
    
    // array for saved memes
    var savedMemes = [ Meme ]()
    
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
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "shiftFrameUp:",
            name: UIKeyboardWillShowNotification,
            object: nil )
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "shiftFrameDown:",
            name: UIKeyboardWillHideNotification,
            object: nil )
    }
    
    func setTextFields()
    {
        // top text field appearance
        topText.defaultTextAttributes = textFieldAttributes
        topText.borderStyle = UITextBorderStyle.None
        topText.textAlignment = NSTextAlignment.Center
        
        // bottom text field appearance
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
        // set the picked image
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
    
    @IBAction func shareMemedImage( sender: UIBarButtonItem )
    {
        // create the meme'd image
        let memedImage = createMemedImage()
        
        // put the image into an array to pass to the activity view
        let memedImageArray = [ memedImage ]
        
        // create the activity view and its completion handler
        let activityView = UIActivityViewController( activityItems: memedImageArray, applicationActivities: nil )
        activityView.completionWithItemsHandler =
        {
            activity, completed, items, error in
            if( completed )
            {
                // save the meme'd image to the model data
                self.saveMeme( memedImage )
                
                // dismiss the activity view
                self.dismissViewControllerAnimated( true, completion: nil )
                
                // reset the meme editor to its default state
                self.resetMemeEditorView()
                
                // segue to the saved memes view
                self.navigationController?.popToRootViewControllerAnimated( true )
            }
        }
        
        // bring up the activity view
        self.presentViewController( activityView, animated: true, completion: nil )
    }
    
    // create the image with overlayed meme text
    func createMemedImage() -> UIImage
    {
        // Render view to an image
        UIGraphicsBeginImageContext( self.view.frame.size )
        
        // hide the navigation bar and the toolbar so only the image itself is saved
        self.navigationController?.navigationBar.hidden = true
        bottomToolbar.hidden = true
        
        // change the aspect so that the meme text fits within the image
        self.memeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
        self.view.drawViewHierarchyInRect( self.view.frame, afterScreenUpdates: true )
        
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        // show the navigation bar and toolbar again after saving the meme'd image;
        // also, reset the aspect mode
        self.navigationController?.navigationBar.hidden = false
        bottomToolbar.hidden = false
        self.memeImageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        return memedImage
    }
    
    // add the new Meme to the model
    func saveMeme( meme: UIImage )
    {
        let newMeme = Meme( topText: topText.text,
                            bottomText: bottomText.text,
                            image: memeImageView.image,
                            memedImage: meme )
        
        Meme.addMeme( newMeme )
    }
    
    // reset meme editor view to default state
    func resetMemeEditorView()
    {
        // reset the default values of the text fields
        // and blank the selected image
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        memeImageView.image = nil
        
        // hide the text fields until the user picks a new image to meme-ify
        topText.hidden = true
        bottomText.hidden = true
        
        // disable the ACTION and CANCEL buttons
        actionButton.enabled = false
        cancelButton.enabled = false
    }
    
    // user cancels meme-ification of an image
    @IBAction func cancelMemeification( sender: UIBarButtonItem )
    {
        // reset the editor
        resetMemeEditorView()
        
        // segue to saved memes, as per spec
        self.navigationController?.popToRootViewControllerAnimated( true )
    }
    
    // user cancels picking an image
    func imagePickerControllerDidCancel( picker: UIImagePickerController )
    {
        // set the cancel flag, so that the previously entered meme text
        // will remain with the previously picked image
        didCancel = true
        
        dismissViewControllerAnimated( true, completion: nil )
    }
    
    // when the user begins entering some meme text,
    // blank out the extisting "TOP" or "BOTTOM" placeholder;
    // otherwise, continue editing meme text
    func textFieldDidBeginEditing( textField: UITextField )
    {
        if( textField.text == "TOP" || textField.text == "BOTTOM" )
        {
            textField.text = ""
        }
        else
        {
            return
        }
    }
    
    // shift the view so the keyboard doesn't obscure the image
    func shiftFrameUp( notification: NSNotification )
    {
        // only shift the view if the user is editing the bottom text field
        if( bottomText.editing )
        {
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![ UIKeyboardFrameEndUserInfoKey ] as NSValue
            self.view.frame.origin.y -= keyboardSize.CGRectValue().height
            
            // disable the ACTION button so that the user can't
            // meme-ify a keyboard-shifted image
            actionButton.enabled = false
        }
    }
    
    // reset the view
    func shiftFrameDown( notification: NSNotification )
    {
        if( bottomText.editing )
        {
            let userInfo = notification.userInfo
            let keyboardSize = userInfo![ UIKeyboardFrameEndUserInfoKey ] as NSValue
            self.view.frame.origin.y += keyboardSize.CGRectValue().height
            
            // re-enable ACTION button, if necessary
            if( !actionButton.enabled )
            {
                actionButton.enabled = true
            }
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
