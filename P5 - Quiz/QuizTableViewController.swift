//
//  QuizTableViewController.swift
//  P5 - Quiz
//
//  Created by Mario Penavades on 06/11/2018.
//  Copyright © 2018 Mario Penavades. All rights reserved.
//

import UIKit

class QuizTableViewController: UITableViewController , QuizTableViewCellDelegate{
    func favOrUnfav(onCell: QuizTableViewCell) {
        if onCell.isFav {
            onCell.favButton.setImage(UIImage(named: "fav.png"), for: .normal)
            onCell.unfavQuiz()
            for i in self.quizzes.indices {
                if self.quizzes[i].id == onCell.id {
                    self.quizzes[i].favourite = false
                    onCell.isFav = !onCell.isFav
                }
            }
            self.quizzesCache = self.quizzes
        } else {
            onCell.favButton.setImage(UIImage(named: "fav2.png"), for: .normal)
            onCell.favQuiz()
            for i in self.quizzes.indices {
                if self.quizzes[i].id == onCell.id {
                    self.quizzes[i].favourite = true
                    onCell.isFav = !onCell.isFav
                }
            }
            self.quizzesCache = self.quizzes
        }
    }
    
    struct Page: Codable{
        let quizzes: [Quiz]
        let pageno: Int
        let nextUrl: String
    }
    struct Quiz: Codable{
        let id: Int
        let question: String
        struct Author: Codable{
            let username: String
        }
        let author: Author?
        struct Attachment: Codable{
            let url: String
        }
        let attachment: Attachment?
        var favourite: Bool
        let tips: [String]
    }
    
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    
    /*Token del usuario*/
    let token = "e2922fc0105402baef54"
    /*Variable para guardar todos los quizzes*/
    var quizzes = [Quiz]()
    /*Sesion para descargar un data*/
    var session = URLSession.shared
    /*Cache para guardar la imagen con su respectivo url*/
    var imgcache = [String : UIImage]()
    var quizzesCache = [Quiz]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadQuizes(_pageno: 1)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.quizzes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quizcell", for: indexPath) as! QuizTableViewCell
        cell.id = quizzes[indexPath.row].id
        cell.delegate = self
        cell.quizQuestion?.text = quizzes[indexPath.row].question
        cell.usernameLabel?.text = quizzes[indexPath.row].author?.username ?? "No author"
        let imgUrl = quizzes[indexPath.row].attachment?.url
        if let img = imgcache[imgUrl ?? ""]{
            cell.quizImage?.image = img
        }else{
            cell.quizImage?.image = UIImage(named: "App-Icono")
            updatePhoto(imgUrl ?? "", for: indexPath)
        }
        cell.isFav = self.quizzes[indexPath.row].favourite
        if self.quizzes[indexPath.row].favourite == true{
            cell.favButton.setImage(UIImage(named: "fav2.png"), for: .normal)
        } else {
            cell.favButton.setImage(UIImage(named: "fav.png"), for: .normal)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    private func downloadQuizes(_pageno: Int){
        DispatchQueue.main.async {
            self.reloadButton.isEnabled = false
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.title = "Downloading..."
        }
        DispatchQueue.global().async {
            let strurl = "https://quiz2019.herokuapp.com/api/quizzes?token=\(self.token)&pageno=\(_pageno)"
            let url = URL(string: strurl)!
            let dataTask = self.session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                guard let data = data else { return }
                if error != nil{
                    DispatchQueue.main.sync {
                        print("Error descargando: \(error!.localizedDescription)")
                    }
                } else if let res = response as? HTTPURLResponse, res.statusCode != 200 {
                    DispatchQueue.main.async {
                        let msg = HTTPURLResponse.localizedString(forStatusCode: res.statusCode)
                        print("Error descargando: \(msg)")
                        self.title = "Access not possible"
                    }
                } else{
                    do{
                        let page = try JSONDecoder().decode(Page.self, from: data)
                        self.quizzesCache = self.quizzesCache + page.quizzes
                        print(page.nextUrl)
                        if (page.nextUrl != "") {
                            return self.downloadQuizes(_pageno: page.pageno+1)
                        } else {
                            DispatchQueue.main.async {
                                self.quizzes = self.quizzesCache
                                self.tableView.reloadData()
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                                self.reloadButton.isEnabled = true
                                self.title = "All Quizzes"
                            }
                            return
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
    
    private func updatePhoto(_ strurl: String, for indexPath: IndexPath) {
        DispatchQueue.global().async {
            if let url = URL(string: strurl),
                let data = try? Data(contentsOf: url),
                let img = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imgcache[strurl] = img
                    self.tableView.reloadRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
    
    @IBAction func reloadQuizzes(_ sender: UIBarButtonItem) {
        self.quizzesCache = []
        //self.quizzes = []
        self.tableView.reloadData()
        self.downloadQuizes(_pageno: 1)
    }
    
    func reloadQuizzes() {
        self.quizzesCache = []
        self.quizzes = []
        downloadQuizes(_pageno: 1)
        self.tableView.reloadData()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        DispatchQueue.main.async {
            if segue.identifier == "goToQuiz"{
                let quizVC = segue.destination as! QuizViewController
                if let ip = self.tableView.indexPathForSelectedRow{
                    quizVC.questionLabel?.text = self.quizzes[ip.row].question
                    quizVC.clues = self.quizzes[ip.row].tips
                    quizVC.id = self.quizzes[ip.row].id
                    if let url = URL(string: self.quizzes[ip.row].attachment?.url ?? "App-Icono"),
                        let data = try? Data(contentsOf: url),
                        let img = UIImage(data: data) {
                            quizVC.quizImage?.image = img
                    } else {
                        quizVC.quizImage?.image = UIImage(named: "App-Icono")
                    }
                }
            }
        }
    }
}
