//
//  DetailViewController.swift
//  Pokedex
//
//  Created by emersonmalca on 7/27/16.
//  Copyright © 2016 Emerson Malca. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UITableViewController {
    
    // We don't need to declare it as an optional because really we should NEVER use this view controller
    // without a pokemon. It that ever happens it deservers to crash and burn
    var pokemon: Pokemon!

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var evolution: UILabel!
    @IBOutlet weak var toggleFavourites: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        hidesBottomBarWhenPushed  = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = pokemon.name
        let share = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(shareTapped))
        let readMore  = UIBarButtonItem(barButtonSystemItem: .Bookmarks, target: self, action: #selector(readMoreTapped))
        navigationItem.rightBarButtonItems = [share, readMore]
        
        // If we had declared pokemon as an optional (var pokemon: Pokemon?) we could do this to safely use it
        /*if let definitelyTherePokemon = pokemon {
            imageView.image = UIImage(named: definitelyTherePokemon?.name)
        }
         */
        
        imageView.image = UIImage(named: pokemon.name)
        name.text = pokemon.name
        type.text = pokemon.type
        summary.text = pokemon.summary
        if pokemon.evolutions.count > 0 {
            evolution.text = "\(pokemon.name) > " + pokemon.evolutions.joinWithSeparator(" > ")
        } else {
            evolution.text = pokemon.name
        }
        
        // Update add to favourites label
        setFavouritesLabel()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // If summary cell
        if indexPath.row == 3 {
            return UITableViewAutomaticDimension
        } else {
            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Assert a condition or return
        guard indexPath.row == 5 else { return }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var favs = favourites()
        
        if let index = favs.indexOf(pokemon.name) {
            favs.removeAtIndex(index)
        } else {
            favs.append(pokemon.name)
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(favs, forKey: "Favourites")
        setFavouritesLabel()
    }
    
    func shareTapped() {
        let vc = UIActivityViewController(activityItems: [pokemon.summary, imageView.image!], applicationActivities: nil)
        presentViewController(vc, animated: true, completion: nil)
    }
    
    func readMoreTapped() {
        if let url = NSURL(string: "http://pokemondb.net/pokedex/\(pokemon.name)") {
            let safariVC = SFSafariViewController(URL: url)
            presentViewController(safariVC, animated: true, completion: nil)
            
        }
    }
    
    func setFavouritesLabel() {
    
        let favs = favourites()
        if favs.contains(pokemon.name) {
            toggleFavourites.text = "Remove from favourites"
        } else {
            toggleFavourites.text = "Add to favourites"
        }
    }
    
    func favourites() -> [String] {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // Return an array of string if there is one (and if it has the right type), or return and empty string array
        // This way 'favourites' is not an optional, it's always a string array
        let favourites = defaults.objectForKey("Favourites") as? [String] ?? [String]()
        return favourites
    }
    
    

}
