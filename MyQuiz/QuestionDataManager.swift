//
//  QuestionDataManager.swift
//  MyQuiz
//
//  Created by 田島諒 on 2018/12/17.
//  Copyright © 2018 Ribast. All rights reserved.
//

import Foundation

class QuestionData {
    var question: String
    var answer1: String
    var answer2: String
    var answer3: String
    var answer4: String
    
    // 正解
    var correctAnswerNumber: Int
    
    // ユーザが選択した選択肢の番号
    var userChoiceAnswerNumber: Int?
    
    // 問題文の番号
    var questionNo: Int = 0
    
    init(questionSourceDataArray: [String]) {
        question = questionSourceDataArray[0]
        answer1 = questionSourceDataArray[1]
        answer2 = questionSourceDataArray[2]
        answer3 = questionSourceDataArray[3]
        answer4 = questionSourceDataArray[4]
        correctAnswerNumber = Int(questionSourceDataArray[5])!
    }
    
    // 正解判定メソッド
    func isCorrect() -> Bool {
        if correctAnswerNumber == userChoiceAnswerNumber {
            return true
        }
        return false
    }
}


class QuestionDataManager {
    static let sharedInstance = QuestionDataManager()
    var questionDataArray = [QuestionData]()
    var nowQuestionIndex: Int = 0
    
    // 初期状態設定
    private init() {
        // これにより外部から呼び出されず、シングルトンが維持される
    }
    
    // 問題の読み込み
    func loadQuestion() {
        // 格納済みの問題があればいったん削除しておく
        questionDataArray.removeAll()
        // 現在の問題のインデックスを初期化
        nowQuestionIndex = 0
        
        // csvファイルパスを取得
        guard let csvFilePath = Bundle.main.path(forResource: "question", ofType: "csv")  else {
            // csvyファイルなしの場合
            print("csvファイルが存在しません")
            return
        }
        
        // csvファイルを読み込む
        do {
            let csvStringData = try String(contentsOfFile: csvFilePath, encoding: String.Encoding.utf8)
            // 一行ずつ読み込む
            csvStringData.enumerateLines(invoking: { (line, stop) in
                // カンマ区切りで分割
                let questionSourceDataArray = line.components(separatedBy: ",")
                // 問題データを格納するオブジェクト作成
                let questionData = QuestionData(questionSourceDataArray: questionSourceDataArray)
                // 問題を追加
                self.questionDataArray.append(questionData)
                // 問題番号を設定
                questionData.questionNo = self.questionDataArray.count
            })
        } catch let error {
            print("csvhファイル読み込みエラーが発生しました:\(error)")
            return
        }
    }
    
    // 次の問題を取り出す
    func nextQuestion() -> QuestionData? {
        if nowQuestionIndex < questionDataArray.count {
            let nextQuestion = questionDataArray[nowQuestionIndex]
            nowQuestionIndex += 1
            return nextQuestion
        }
        return nil
    }
}
