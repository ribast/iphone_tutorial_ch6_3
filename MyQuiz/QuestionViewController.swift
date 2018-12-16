//
//  QuestionViewController.swift
//  MyQuiz
//
//  Created by 田島諒 on 2018/12/17.
//  Copyright © 2018 Ribast. All rights reserved.
//

import UIKit
import AudioToolbox

class QuestionViewController: UIViewController {
    var questionData: QuestionData!
    @IBOutlet weak var questionNoLabel: UILabel!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    @IBOutlet weak var correctImageView: UIImageView!
    @IBOutlet weak var incorrectImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初期データ設定
        questionNoLabel.text = "Q.\(questionData.questionNo)"
        answer1Button.setTitle(questionData.answer1, for: UIControl.State.normal)
        answer2Button.setTitle(questionData.answer2, for: UIControl.State.normal)
        answer3Button.setTitle(questionData.answer3, for: UIControl.State.normal)
        answer4Button.setTitle(questionData.answer4, for: UIControl.State.normal)
    }
    
    @IBAction func tapAnswer1Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 1
        // 次の問題に進む
        goNextQuestionAnimation()
    }
    
    @IBAction func tapAnswer2Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 2
        // 次の問題に進む
        goNextQuestionAnimation()
    }
    
    @IBAction func tapAnswer3Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 3
        // 次の問題に進む
        goNextQuestionAnimation()
    }
    @IBAction func tapAnswer4Button(_ sender: Any) {
        questionData.userChoiceAnswerNumber = 4
        // 次の問題に進む
        goNextQuestionAnimation()
    }
    
    // 次の問題にアニメーションで進む
    func goNextQuestionAnimation() {
        if questionData.isCorrect() {
            // 正解のアニメーションを表示しながら次の問題へ遷移
            goNextQuestionWithCorrectAnimation()
        } else {
            // 不正解のアニメーションを表示しながら次の問題へ遷移
            goNextQuestionWithIncorrectAnimation()
        }
    }
    
    // 正解アニメーション
    func goNextQuestionWithCorrectAnimation() {
        // 正解音
        AudioServicesPlayAlertSound(1025)
        
        // アニメーション
        UIView.animate(withDuration: 2.0, animations: {
            // アルファ値を1.0に変化される（初期値はstoryboard上で0.0に設定）
            self.correctImageView.alpha = 1.0
        }) { (Bool) in
            self.goNextQuestion()
        }
    }
    
    // 不正解アニメーション
    func goNextQuestionWithCIncorrectAnimation() {
        // 正解音
        AudioServicesPlayAlertSound(1006)
        
        // アニメーション
        UIView.animate(withDuration: 2.0, animations: {
            // アルファ値を1.0に変化される（初期値はstoryboard上で0.0に設定）
            self.incorrectImageView.alpha = 1.0
        }) { (Bool) in
            self.goNextQuestion()
        }
    }
    
    func goNextQuestion() {
        // 問題文の取り出し
        guard let nextQuestion = QuestionDataManager.sharedInstance.nextQuestion() else {
            // 問題文がなければ結果画面に移行
            if let resultViewController = storyboard?.instantiateViewController(withIdentifier: "result") as? ResultViewController {
                // segueを利用しない明示的な画面遷移
                present(resultViewController, animated: true, completion: nil)
            }
            return
        }
        
        // 問題文がある場合は自分に遷移
        if let nextQuestionViewController = storyboard?.instantiateViewController(withIdentifier: "question") as? QuestionViewController {
                nextQuestionViewController.questionData = nextQuestion
                present(nextQuestionViewController, animated: true, completion: nil)
        }
        
    }
}
