//
//  RecipeViewController.swift
//  MeatCrush
//
//  Created by Ryan Dines on 8/12/17.
//  Copyright © 2017 Ryan Dines. All rights reserved.
//

import Foundation
import UIKit

class RecipeViewController: UIViewController {
    
    var currentLevelNum: Int!
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeIngredients: UIImageView!
    
    @IBOutlet weak var recipeInstructions: UIImageView!
    
    // 320 x 189.3333 (1/3 height from 568)
    
    var recipeImageDict: [Int : UIImage] = [1 : UIImage.init(named: "GrilledCheeseRecipeImage")!,
                                            2 : UIImage.init(named: "MacAndCheeseRecipeImage")!,
                                            3 : UIImage.init(named: "ChickenParmRecipeImage")!,
                                            4 : UIImage.init(named: "SandwichRecipeImage")!]
    var recipeIngredientsDict: [Int : UIImage] = [1 : UIImage.init(named: "GrilledCheeseIngredients")!,
                                                  2 : UIImage.init(named: "GrilledCheeseIngredients")!,
                                                  3 : UIImage.init(named: "GrilledCheeseIngredients")!,
                                                  4 : UIImage.init(named: "GrilledCheeseIngredients")!]
    var recipeInstructionssDict: [Int : UIImage] = [1 : UIImage.init(named: "GrilledCheeseInstructions")!,
                                                    2 : UIImage.init(named: "GrilledCheeseInstructions")!,
                                                    3 : UIImage.init(named: "GrilledCheeseInstructions")!,
                                                    4 : UIImage.init(named: "GrilledCheeseInstructions")!]
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.black
        recipeImage.image = recipeImageDict[currentLevelNum]
        recipeIngredients.image = recipeIngredientsDict[currentLevelNum]
        recipeInstructions.image = recipeInstructionssDict[currentLevelNum]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) { 
            print("The recipe view controller dismissed itself.")
        }
    }
    
}
