//
//  ChoseTrainingModeViewController.swift
//  LanguageApp
//
//  Created by Михаил Малышев on 11/05/2020.
//  Copyright © 2020 Mikhail Malyshev. All rights reserved.
//

import UIKit

class ChooseTrainingModeViewController: UIViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trainingVC = segue.destination as! TrainingQuestionViewController
        switch segue.identifier {
        case "translateWord":
            trainingVC.mode = "translateWord"
        case "wordTranslate":
            trainingVC.mode = "wordTranslate"
        default:
            break
        }
    }
}
