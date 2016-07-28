//
//  FavouritesViewController.swift
//  Pokedex
//
//  Created by emersonmalca on 7/27/16.
//  Copyright © 2016 Emerson Malca. All rights reserved.
//

import UIKit

class FavouritesViewController: UICollectionViewController {
    
    var favourites = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Favourites"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let savedFavourites = defaults.objectForKey("Favourites") as? [String] ?? [String]()
        
        if favourites != savedFavourites {
            favourites = savedFavourites
             collectionView?.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favourites.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        let imageView = cell.viewWithTag(1234) as? UIImageView
        let name = favourites[indexPath.item]
        imageView?.image = UIImage(named: name)
        return cell
    }

}
