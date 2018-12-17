//
//  ResultViewController.swift
//  MyQuiz
//
//  Created by 田島諒 on 2018/12/17.
//  Copyright © 2018 Ribast. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var correctPercentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let questionCount = QuestionDataManager.sharedInstance.questionDataArray.count
        
        // 正解数を取得
        var correctCount :Int = 0
        for questionData in QuestionDataManager.sharedInstance.questionDataArray {
            if questionData.isCorrect() {
                correctCount += 1
            }
        }
        
        // 正解率
        let correctPercent = (Float(correctCount) / Float(questionCount)) * 100
        correctPercentLabel.text = String(format:"%.1f", correctPercent) + "%"
    }

}
