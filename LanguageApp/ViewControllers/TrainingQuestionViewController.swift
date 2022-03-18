//
//  TrainingQuestionViewController.swift
//  LanguageApp
//
//  Created by Михаил Малышев on 04/05/2020.
//  Copyright © 2020 Mikhail Malyshev. All rights reserved.
//

import UIKit
import RealmSwift

class TrainingQuestionViewController: UIViewController {

    private let realm = try! Realm()
    private lazy var words: Results<Word> = { self.realm.objects(Word.self) }()
    private lazy var wordsIsNotLearned: Results<Word> = { self.realm.objects(Word.self).filter("isLearn == false")}()
    var mode = ""
    private var buttons: [UIButton] = []
    private var stage = 0
    private var rightIndex = 0
    private var currentWordsCount = 0
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var questionsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttons.append(button1)
        buttons.append(button2)
        buttons.append(button3)
        buttons.append(button4)
        resultLabel.isHidden = true
        
        startRound()
    }
    
    private func startRound() {
        
        if stage + 1 > wordsIsNotLearned.count {
            showResultView()
            return
        }
             
        for button in buttons {
            button.backgroundColor = .lightGray
            button.isEnabled = true
        }
        let randomWords = getRandomListOf(words: words)
        countLabel.text = "\(stage + 1) из \(wordsIsNotLearned.count)"
        rightIndex = Int.random(in: 0..<buttons.count)
        
        switch mode {
        case "wordTranslate":
            wordLabel.text = wordsIsNotLearned[stage].word
            buttons[rightIndex].setTitle(wordsIsNotLearned[stage].translate, for: .normal)
            for index in 0...3 {
                guard index != rightIndex else { continue }
                if wordsIsNotLearned[stage].translate == randomWords[index].translate {
                    buttons[index].setTitle(randomWords[index + 2].translate, for: .normal)
                } else {
                    buttons[index].setTitle(randomWords[index].translate, for: .normal)
                }
            }
        case "translateWord":
            wordLabel.text = wordsIsNotLearned[stage].translate
            buttons[rightIndex].setTitle(wordsIsNotLearned[stage].word, for: .normal)
            for index in 0...3 {
                guard index != rightIndex else { continue }
                if wordsIsNotLearned[stage].word == randomWords[index].word {
                    buttons[index].setTitle(randomWords[index + 2].word, for: .normal)
                } else {
                    buttons[index].setTitle(randomWords[index].word, for: .normal)
                }
            }
        default:
            break
        }
        
        stage += 1
    }
    
    @IBAction func answerButton(_ sender: UIButton) {
        guard let buttonsPressedIndex = buttons.firstIndex(of: sender) else {
            return
        }
        if buttonsPressedIndex == rightIndex {
            sender.backgroundColor = .systemGreen
            currentWordsCount += 1
        } else {
            sender.backgroundColor = .red
            buttons[rightIndex].backgroundColor = .systemGreen
        }
        
        let time = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.startRound()
        }
        for button in buttons {
            button.isEnabled = false
        }
    }
    
    private func getRandomListOf(words: Results<Word>!) -> [Word] {
        var randomWords: [Word] = []
        let randomWordsFromRealm = words.shuffled()
        for word in randomWordsFromRealm {
            randomWords.append(word)
        }
        return randomWords
    }
    
    private func showResultView() {
        questionsStackView.isHidden = true
        resultLabel.isHidden = false
        resultLabel.text = "Ты правильно ответил на \(currentWordsCount) из \(stage) вопросов! Молодец!"
    }
    
}
