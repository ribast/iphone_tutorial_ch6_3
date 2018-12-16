//
//  StartViewController.swift
//  MyQuiz
//
//  Created by 田島諒 on 2018/12/17.
//  Copyright © 2018 Ribast. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 問題文の読み込み
        QuestionDataManager.sharedInstance.loadQuestion()
        // 遷移先画面の読み込み
        guard let nextViewController = segue.destination as? QuestionViewController else {
            // 取得できずに終了
            return
        }
        // 問題文の取り出し
        guard let questionData = QuestionDataManager.sharedInstance.nextQuestion() else {
            // 取得できずに終了
            return
        }
        
        // 問題文のセット
        nextViewController.questionData = questionData
    }
    
    // タイトルに戻ってくるときに呼び出される処理
    @IBAction func goToTitle(_ segue: UIStoryboardSegue){
        
    }
}
