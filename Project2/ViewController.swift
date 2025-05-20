import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    
    var questionAsked = 0
    var maxQuestion = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Score", style: .plain, target: self, action: #selector(showScore))

        askQuestion()
    }
        
    func askQuestion(action: UIAlertAction! = nil) {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            
            button1.setImage(UIImage(named: countries[0]), for: .normal)
            button2.setImage(UIImage(named: countries[1]), for: .normal)
            button3.setImage(UIImage(named: countries[2]), for: .normal)
            
        title = "\(countries[correctAnswer].uppercased()) | Score: \(score)"
        
        }
    

        // Do any additional setup after loading the view.
    
    // MARK: - Navigation

    @IBAction func buttonTapped(_ sender: UIButton) {
        questionAsked += 1
        
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Good!, Your score is \(score)"
        } else {
            title = "Wrong"
            score -= max(0, score - 1)
            let chosenCountry = countries[sender.tag]
            message = "That is the Flag of \(chosenCountry.uppercased()).\nYour Score is \(score)"
        }
        
        if questionAsked == maxQuestion {
            let finalAlert = UIAlertController(title: "Game Over", message: "You Scored \(score) out of \(maxQuestion).", preferredStyle: .alert)
            finalAlert.addAction(UIAlertAction(title: "Play Again", style: .default) { [weak self] _ in
                self?.score = 0
                self?.questionAsked = 0
                self?.askQuestion()
            })
            present(finalAlert, animated: true)
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
        
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Your Score", message: "Your current score is \(score).", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(ac, animated: true)
    }
}
