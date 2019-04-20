//
//  QuizTableViewCell.swift
//  P5 - Quiz
//
//  Created by Mario Penavades on 06/11/2018.
//  Copyright © 2018 Mario Penavades. All rights reserved.
//

import UIKit

protocol QuizTableViewCellDelegate: class {
    func favOrUnfav(onCell: QuizTableViewCell)
}

class QuizTableViewCell: UITableViewCell {
    struct Quiz: Codable {
        let id: Int
        let favourite: Bool
    }
    weak var delegate: QuizTableViewCellDelegate?
   
    let token = "e2922fc0105402baef54"
    var id = 0
    var isFav = false;
    @IBOutlet weak var quizQuestion: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    @IBAction func favOrUnfav(_ sender: UIButton) {
        delegate?.favOrUnfav(onCell: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func favQuiz(){
        DispatchQueue.global().async {
            let url = URL(string: "https://quiz2019.herokuapp.com/api/users/tokenOwner/favourites/\(self.id)?token=\(self.token)")!
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil{
                    DispatchQueue.main.sync {
                        print("Error descargando: \(error!.localizedDescription)")
                    }
                } else if let res = response as? HTTPURLResponse, res.statusCode != 200 {
                    DispatchQueue.main.async {
                        let msg = HTTPURLResponse.localizedString(forStatusCode: res.statusCode)
                        print("Error descargando: \(msg)")
                    }
                } else{
                    if let res = response as? HTTPURLResponse{
                        print(res.statusCode)
                    }
                    print("He hecho fav")
                }
            }
            task.resume()
        }
    }
    
    func unfavQuiz(){
        DispatchQueue.global().async {
            let url = URL(string: "https://quiz2019.herokuapp.com/api/users/tokenOwner/favourites/\(self.id)?token=\(self.token)")!
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
                if error != nil{
                    DispatchQueue.main.sync {
                        print("Error descar: \(error!.localizedDescription)")
                    }
                } else if let res = response as? HTTPURLResponse, res.statusCode != 200 {
                    DispatchQueue.main.async {
                        print(res.statusCode)
                        let msg = HTTPURLResponse.localizedString(forStatusCode: res.statusCode)
                        print("Error descargando: \(msg)")
                    }
                } else{
                    if let res = response as? HTTPURLResponse{
                        print(res.statusCode)
                    }
                    print("He hecho unfav")
                }
            }
            task.resume()
        }
    }
}
