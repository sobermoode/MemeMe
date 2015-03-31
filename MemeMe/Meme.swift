//
//  Meme.swift
//  MemeMe
//
//  Created by Aaron Justman on 3/31/15.
//  Copyright (c) 2015 AaronJ. All rights reserved.
//

import Foundation
import UIKit

struct Meme
{
    var topText: String!
    var bottomText: String!
    var image: UIImage!
    var memedImage: UIImage!
}

extension Meme
{
    // Meme model data for saved memes
    static var allMemes = [ Meme ]()
    
    // adds a new Meme to the model
    static func addMeme( newMeme: Meme )
    {
        self.allMemes.append( newMeme )
    }
}