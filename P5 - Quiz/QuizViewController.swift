//
//  ViewController.swift
//  P5 - Quiz
//
//  Created by Mario Penavades on 30/10/2018.
//  Copyright © 2018 Mario Penavades. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {
    struct Answer: Codable{
        let quizId: Int
        let answer: String
        let result: Bool
    }

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var checkButton: UIButton!
    
    var clues = [String]()
    var id = 0
    /*Token del usuario*/
    let token = "e2922fc0105402baef54"
    var answers = Answer(quizId: 1, answer: "answer", result: true)
    /*Sesion para descargar un data*/
    var session = URLSession.shared
    var respuesta = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToClues"{
            let clueVC = segue.destination as! ClueTableViewController
            clueVC.clues = self.clues
        }
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        checkAnswer()
    }
    func checkAnswer(){
        self.respuesta = self.answerTextField?.text?.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        let strurl = "https://quiz2019.herokuapp.com/api/quizzes/\(id)/check?token=\(token)&answer=\(respuesta)"
        let url = URL(string: strurl)!
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let data = data else{ return }
            if error != nil{
                DispatchQueue.main.sync {
                    print("Error descargando: \(error!.localizedDescription)")
                }
            } else if let res = response as? HTTPURLResponse, res.statusCode != 200 {
                DispatchQueue.main.async {
                    let msg = HTTPURLResponse.localizedString(forStatusCode: res.statusCode)
                    print("Error descargando: \(msg)")
                    self.title = "Desactualizado"
                }
            } else{
                do{
                    let answer = try JSONDecoder().decode(Answer.self, from: data)
                        DispatchQueue.main.async {
                            self.answers = answer
                            if(self.answers.result == false){
                                let alertErrorFechas = UIAlertController(title: "¡Error!", message: "Respuesta errónea", preferredStyle: .alert)
                                alertErrorFechas.addAction(UIAlertAction(title: "OK", style: .default, handler: {(aa :UIAlertAction) in
                                    print("Se pulso OK")}))
                                self.present(alertErrorFechas, animated: true)
                            } else {
                                let alertErrorFechas = UIAlertController(title: "¡Acierto!", message: "Respuesta correcta", preferredStyle: .alert)
                                alertErrorFechas.addAction(UIAlertAction(title: "OK", style: .default, handler: {(aa :UIAlertAction) in
                                    print("Se pulso OK")}))
                                self.present(alertErrorFechas, animated: true)
                            }
                        }
                } catch let err{
                    DispatchQueue.main.async {
                        print("Error extrayendo JSON = \(err.localizedDescription)")
                    }
                }
            }
        }
        dataTask.resume()
    }
    
}

