//
//  QuizBrain.swift
//  Pariquiz
//
//  Created by Ravil on 07.10.2023.
//

import Foundation

struct QuizBrain {
    
    var questionNumber = 0
    var score = 0
    
    let quiz = [
        Question(q: "Who won the FIFA World Cup in 2018?", a: ["Brazil", "France", "Germany", "Argentina"], correctAnswer: "France"),
        Question(q: "Which country hosted the 2014 FIFA World Cup?", a: ["Brazil", "South Africa", "Germany", "Japan"], correctAnswer: "Brazil"),
        Question(q: "Who is known as the 'Egyptian King' in football?", a: ["Cristiano Ronaldo", "Lionel Messi", "Mohamed Salah", "Neymar Jr."], correctAnswer: "Mohamed Salah"),
        Question(q: "Which club is known as 'The Red Devils'?", a: ["Liverpool", "Chelsea", "Manchester United", "Arsenal"], correctAnswer: "Manchester United"),
        Question(q: "Which country has won the most FIFA World Cup titles?", a: ["Germany", "Argentina", "Brazil", "Italy"], correctAnswer: "Brazil"),
        Question(q: "Who won the Ballon d'Or in 2021?", a: ["Lionel Messi", "Cristiano Ronaldo", "Robert Lewandowski", "Kevin De Bruyne"], correctAnswer: "Lionel Messi"),
        Question(q: "Which English club won the Champions League in 2019?", a: ["Manchester City", "Liverpool", "Chelsea", "Tottenham Hotspur"], correctAnswer: "Liverpool"),
        Question(q: "Who is the top scorer in the history of the Premier League?", a: ["Thierry Henry", "Wayne Rooney", "Alan Shearer", "Frank Lampard"], correctAnswer: "Alan Shearer"),
        Question(q: "Which club did Cristiano Ronaldo play for before joining Manchester United in 2021?", a: ["Real Madrid", "Juventus", "Sporting Lisbon", "Barcelona"], correctAnswer: "Juventus"),
        Question(q: "What is the term for an attempt to score by kicking the ball into the opponent's goal?", a: ["Dribble", "Tackle", "Shot", "Pass"], correctAnswer: "Shot")
    ]


    func getQuestionText() -> String {
        return quiz[questionNumber].text
    }
    
    //Need a way of fetching the answer choices.
    func getAnswers() -> [String] {
        return quiz[questionNumber].answers
    }
    
    func getProgress() -> Float {
        return Float(questionNumber) / Float(quiz.count)
    }
    
    mutating func getScore() -> Int {
        return score
    }
    
     mutating func nextQuestion() {
        
        if questionNumber + 1 < quiz.count {
            questionNumber += 1
        } else {
            questionNumber = 0
        }
    }
    
    mutating func checkAnswer(userAnswer: String) -> Bool {
        //Need to change answer to rightAnswer here.
        if userAnswer == quiz[questionNumber].rightAnswer {
            score += 1
            return true
        } else {
            return false
        }
    }
}


