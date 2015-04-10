//
//  SavedMemesViewController.swift
//  MemeMe
//
//  Created by Aaron Justman on 3/31/15.
//  Copyright (c) 2015 AaronJ. All rights reserved.
//

import UIKit

class SavedMemesViewController: UITabBarController, UITableViewDelegate
{
    // flag for launching app for the first time;
    // otherwise, the SavedMemesViewController will automatically segue back
    // to the meme editor if the user presses CANCEL and is sent to the
    // SavedMemesViewController without any saved memes
    var isFirstTime: Bool = true
    
    override func viewWillAppear( animated: Bool )
    {
        // this is now the initial view controller
        // will transition to the meme editor if there are no saved memes
        super.viewWillAppear( animated )
        
        // only show the meme editor on app launch
        if( isFirstTime )
        {
            if( Meme.allMemes.count == 0 )
            {
                // instantiate the MemeEditorViewController and segue there
                let memeEditorViewController = self.storyboard?.instantiateViewControllerWithIdentifier( "MemeEditorViewController" ) as MemeEditorViewController
                
                self.navigationController?.showViewController( memeEditorViewController, sender: self )
                
                // not coming to the SavedMemesViewController on app launch, anymore
                isFirstTime = false
            }
        }
            
        // every other time the SavedMemesViewEditor is shown, it will need to be set up correctly
        else
        {
            // hide the back button,
            // set the title,
            // create a + button to return to the meme editor view
            self.navigationItem.setHidesBackButton( true, animated: false )
            self.navigationItem.title = "Sent Memes"
            self.navigationItem.rightBarButtonItem = UIBarButtonItem( barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector( "returnToMemeEditor" ) )
        }
    }
    
    // return to the meme editor
    func returnToMemeEditor()
    {
        let memeEditorViewController = self.storyboard?.instantiateViewControllerWithIdentifier( "MemeEditorViewController" ) as MemeEditorViewController
        
        self.navigationController?.showViewController( memeEditorViewController, sender: self )
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
