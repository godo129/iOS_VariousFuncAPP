//
//  GameViewController.swift
//  Widget_projects
//
//  Created by comsoft on 2021/06/09.
//

import UIKit
import AVFoundation



class GameViewController: UIViewController {
    
    @IBOutlet weak var firstPic: UIImageView!
    @IBOutlet weak var secondPic: UIImageView!
    @IBOutlet weak var thirdPic: UIImageView!
    @IBOutlet weak var restartButton: UIImageView!
    @IBOutlet weak var resultPic: UIImageView!
    @IBOutlet weak var ChoosedDoor: UILabel!
    
    
    var items = ["coin","Monster1","Monster2"]
    
    let gameExplainText = "코인이 있을 문을 예상해 보세요!"

    @IBOutlet weak var CoinText: UILabel!
    
    @IBAction func goBack(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
        
           }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 음악 재생 안되게
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode:  .default)
            try AVAudioSession.sharedInstance().setActive(false)
            //print("aa")
            
        } catch {
            print(error.localizedDescription)
        }
  
        self.picFirstSetting()
        

        
        
        let numString = UserDefaults.standard.string(forKey: "Points")
        
        self.CoinText.text = numString! + " point"
        
        self.ChoosedDoor.text = gameExplainText

        
    }
    

    // 점수 갱신
    func UpdateScore(){
        
        
        // 데이터 불러오기
        let UpdatePoint = UserDefaults.standard.integer(forKey: "Points") + 1
        let pointString = String(UpdatePoint)
        
        // 데이터 저장하기
        UserDefaults.standard.set(UpdatePoint, forKey: "Points")
        
        self.CoinText.text = pointString + " point"
    
    }
    
    
    func ClickOneOpenTwo(answer: Int){
        let alert = UIAlertController(title: "선택을 바꾸겠습니까?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "선택 유지", style: .destructive, handler: { (action) in
            if answer == 1 {
                self.resultPic.image = self.winImage()
                self.UpdateScore()
                self.firstPic.image = self.coinImage()
                self.thirdPic.image = self.secondImage()
                self.ChoosedDoor.text = "You choosed 1st door"
                self.picClear()
            }
            else if answer == 3 {
                self.resultPic.image = self.defeatImage()
                self.firstPic.image = self.secondImage()
                self.thirdPic.image = self.coinImage()
                self.ChoosedDoor.text = "You choosed 1st door"
                self.picClear()
                
            }        }))
        alert.addAction(UIAlertAction(title: "세번째 문으로 변경", style: .destructive, handler: { (action) in
            
            if answer == 3 {
                self.resultPic.image = self.winImage()
                self.UpdateScore()
                self.thirdPic.image = self.coinImage()
                self.firstPic.image = self.secondImage()
                self.ChoosedDoor.text = "You choosed 3rd door"
                self.picClear()
            }
            else if answer == 1 {
                self.resultPic.image = self.defeatImage()
                self.thirdPic.image = self.secondImage()
                self.firstPic.image = self.coinImage()
                self.ChoosedDoor.text = "You choosed 3rd door"
                self.picClear()
                
            }
                                            
        }))
        
        self.present(alert,animated: true)    }
    
    func ClickOneOpenThird(answer: Int){
        let alert = UIAlertController(title: "선택을 바꾸겠습니까?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "선택 유지하기", style: .destructive, handler: { (action) in
            
                                        if answer == 1 {
                                            self.resultPic.image = self.winImage()
                                            self.UpdateScore()
                                            self.firstPic.image = self.coinImage()
                                            self.secondPic.image = self.secondImage()
                                            self.ChoosedDoor.text = "You choosed 1st door"
                                            self.picClear()
                                        }
                                        else if answer == 2 {
                                            self.resultPic.image = self.defeatImage()
                                            self.firstPic.image = self.secondImage()
                                            self.secondPic.image = self.coinImage()
                                            self.ChoosedDoor.text = "You choosed 1st door"
                                            self.picClear()
                                            
                                        }
                                        
                                        
        }))
        alert.addAction(UIAlertAction(title: "두번째 문으로 변경", style: .destructive, handler: { (action) in
            if answer == 2 {
                self.resultPic.image = self.winImage()
                self.UpdateScore()
                self.secondPic.image = self.coinImage()
                self.firstPic.image = self.secondImage()
                self.ChoosedDoor.text = "You choosed 2nd door"
                self.picClear()
            }
            else if answer == 1 {
                self.resultPic.image = self.defeatImage()
                self.secondPic.image = self.secondImage()
                self.firstPic.image = self.coinImage()
                self.ChoosedDoor.text = "You choosed 2nd door"
                self.picClear()
                
            }
                                            
        }))
        
        self.present(alert,animated: true)    }
    
    
    
    
    
    
    @objc func picFirst(){
        
        var nums = [1,2]
        items.shuffle()
        
        items.shuffle()
        let firstDoor = items[0]
        let secondDoor = items[1]
        let thirdDoor = items[2]
        
        if secondDoor == "coin" {
            
            
            self.thirdPic.image = firstImage()
            ClickOneOpenThird(answer: 2)
        }
        else if thirdDoor == "coin" {
            
            self.secondPic.image = firstImage()
            ClickOneOpenTwo(answer: 3)        }
        else {
            
            nums.shuffle()
            
            if nums[0] == 2{
                self.secondPic.image = firstImage()
                ClickOneOpenTwo(answer: 1)
                         }
            else {
                self.thirdPic.image = firstImage()
                ClickOneOpenThird(answer: 1)
                             }
    }
        
     

}
    
    func ClickTwoOpenOne(answer: Int){
        let alert = UIAlertController(title: "선택을 바꾸겠습니까?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "선택 유지", style: .destructive, handler: { (action) in
            if answer == 2 {
                self.resultPic.image = self.winImage()
                self.UpdateScore()
                self.secondPic.image = self.coinImage()
                self.thirdPic.image = self.secondImage()
                self.ChoosedDoor.text = "You choosed 2nd door"
                self.picClear()
            }
            else if answer == 3 {
                self.resultPic.image = self.defeatImage()
                self.secondPic.image = self.secondImage()
                self.thirdPic.image = self.coinImage()
                self.ChoosedDoor.text = "You choosed 2nd door"
                self.picClear()
                
            }        }))
        alert.addAction(UIAlertAction(title: "세번째 문으로 변경", style: .destructive, handler: { (action) in
            
            if answer == 3 {
                self.resultPic.image = self.winImage()
                self.UpdateScore()
                self.thirdPic.image = self.coinImage()
                self.secondPic.image = self.secondImage()
                self.ChoosedDoor.text = "You choosed 3rd door"
                self.picClear()
            }
            else if answer == 2 {
                self.resultPic.image = self.defeatImage()
                self.secondPic.image = self.secondImage()
                self.thirdPic.image = self.coinImage()
                self.ChoosedDoor.text = "You choosed 3rd door"
                self.picClear()
                
            }
                                            
        }))
        
        self.present(alert,animated: true)    }
    
    
    func ClickTwoOpenThird(answer: Int){
        let alert = UIAlertController(title: "선택을 바꾸겠습니까?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "선택 유지", style: .destructive, handler: { (action) in
            if answer == 2 {
                self.resultPic.image = self.winImage()
                self.UpdateScore()
                self.secondPic.image = self.coinImage()
                self.firstPic.image = self.secondImage()
                self.ChoosedDoor.text = "You choosed 2nd door"
                self.picClear()
            }
            else if answer == 1 {
                self.resultPic.image = self.defeatImage()
                self.secondPic.image = self.secondImage()
                self.firstPic.image = self.coinImage()
                self.ChoosedDoor.text = "You choosed 2nd door"
                self.picClear()
                
            }        }))
        alert.addAction(UIAlertAction(title: "첫번째 문으로 변경", style: .destructive, handler: { (action) in
            
            if answer == 1 {
                self.resultPic.image = self.winImage()
                self.UpdateScore()
                self.firstPic.image = self.coinImage()
                self.secondPic.image = self.secondImage()
                self.ChoosedDoor.text = "You choosed 1st door"
                self.picClear()
            }
            else if answer == 2 {
                self.resultPic.image = self.defeatImage()
                self.firstPic.image = self.secondImage()
                self.secondPic.image = self.coinImage()
                self.ChoosedDoor.text = "You choosed 1st door"
                self.picClear()
                
            }
                                            
        }))
        
        self.present(alert,animated: true)    }
    
    
    @objc func picSecond() {
        var nums = [1,2]
        
        items.shuffle()
        let firstDoor = items[0]
        let secondDoor = items[1]
        let thirdDoor = items[2]
        
        if firstDoor == "coin" {
            
            self.thirdPic.image = firstImage()
            ClickTwoOpenThird(answer: 1)
        }
        else if thirdDoor == "coin" {
            self.firstPic.image = firstImage()
            ClickTwoOpenOne(answer: 3)        }
        else {
            
            
            nums.shuffle()
            
            if nums[0] == 1{
                self.firstPic.image = firstImage()
                ClickTwoOpenOne(answer: 2)
                         }
            else {
                self.thirdPic.image = firstImage()
                ClickTwoOpenThird(answer: 2)
                             }
    }    }
    
    
    
    func ClickThirdOpenOne(answer: Int){
        let alert = UIAlertController(title: "선택을 바꾸겠습니까?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "선택 유지", style: .destructive, handler: { (action) in
            if answer == 3 {
                self.resultPic.image = self.winImage()
                self.UpdateScore()
                self.thirdPic.image = self.coinImage()
                self.secondPic.image = self.secondImage()
                self.ChoosedDoor.text = "You choosed 3rd door"
                self.picClear()
            }
            else if answer == 2  {
                self.resultPic.image = self.defeatImage()
                self.thirdPic.image = self.secondImage()
                self.secondPic.image = self.coinImage()
                self.ChoosedDoor.text = "You choosed 3rd door"
                self.picClear()
                
            }        }))
        alert.addAction(UIAlertAction(title: "두번째 문으로 변경", style: .destructive, handler: { (action) in
            
            if answer == 2 {
                self.resultPic.image = self.winImage()
                self.UpdateScore()
                self.secondPic.image = self.coinImage()
                self.thirdPic.image = self.secondImage()
                self.ChoosedDoor.text = "You choosed 2nd door"
                self.picClear()
            }
            else if answer == 3 {
                self.resultPic.image = self.defeatImage()
                self.secondPic.image = self.secondImage()
                self.thirdPic.image = self.coinImage()
                self.ChoosedDoor.text = "You choosed 2nd door"
                self.picClear()
                
            }
            
                                            
        }))
        
        self.present(alert,animated: true)    }
    
    
    func ClickThirdOpenTwo(answer: Int){
        let alert = UIAlertController(title: "선택을 바꾸겠습니까?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "선택 유지", style: .destructive, handler: { (action) in
            if answer == 3 {
                self.resultPic.image = self.winImage()
                self.UpdateScore()
                self.thirdPic.image = self.coinImage()
                self.firstPic.image = self.secondImage()
                self.ChoosedDoor.text = "You choosed 3rd door"
                self.picClear()
            }
            else if answer == 1 {
                self.resultPic.image = self.defeatImage()
                self.thirdPic.image = self.secondImage()
                self.firstPic.image = self.coinImage()
                self.ChoosedDoor.text = "You choosed 3rd door"
                self.picClear()
                
                
            }        }))
        alert.addAction(UIAlertAction(title: "첫번째 문으로 변경", style: .destructive, handler: { (action) in
            
            if answer == 1 {
                self.resultPic.image = self.winImage()
                self.UpdateScore()
                self.firstPic.image = self.coinImage()
                self.thirdPic.image = self.secondImage()
                self.ChoosedDoor.text = "You choosed 1st door"
                self.picClear()
            }
            else if answer == 3 {
                self.resultPic.image = self.defeatImage()
                self.firstPic.image = self.secondImage()
                self.thirdPic.image = self.coinImage()
                self.ChoosedDoor.text = "You choosed 1st door"
                self.picClear()
                
            }
                                            
        }))
        
        self.present(alert,animated: true)    }
    
    
    
    
    @objc func picThird() {
        
        var nums = [1,2]
        
        items.shuffle()
        let firstDoor = items[0]
        let secondDoor = items[1]
        let thirdDoor = items[2]
        
        if firstDoor == "coin" {
            
            self.secondPic.image = firstImage()
            ClickThirdOpenTwo(answer: 1)
        }
        else if secondDoor == "coin" {
            self.firstPic.image = firstImage()
            ClickThirdOpenOne(answer: 2)        }
        else {
            
            
            nums.shuffle()
            
            if nums[0] == 1{
                self.firstPic.image = firstImage()
                ClickThirdOpenOne(answer: 3)
                         }
            else {
                self.secondPic.image = firstImage()
                ClickThirdOpenTwo(answer: 3)
                             }
    }
        
    }
    
    
    
    
    
    @objc func picClean(){
        
        
    }
    
    @objc func picClear() {
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(self.picClean))
        self.firstPic.addGestureRecognizer(tapGesture1)
        self.firstPic.isUserInteractionEnabled = true
            
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.picClean))
        self.secondPic.addGestureRecognizer(tapGesture2)
        self.secondPic.isUserInteractionEnabled = true
            
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(self.picClean))
        self.thirdPic.addGestureRecognizer(tapGesture3)
        self.thirdPic.isUserInteractionEnabled = true
        
        
        let image = UIImage(named: "restart.png")
        self.restartButton.image = image
        
        let tapGestureRestartButton = UITapGestureRecognizer(target: self, action: #selector(self.ClickRestartButton))
        self.restartButton.addGestureRecognizer(tapGestureRestartButton)
        self.restartButton.isUserInteractionEnabled = true
        
    
    }
    
    @objc func ClickRestartButton() {
        
        
        let tapGestureRestartButton = UITapGestureRecognizer(target: self, action: #selector(self.ClickedRestartButton))
        self.restartButton.addGestureRecognizer(tapGestureRestartButton)
        
        
        
    }
    
    @objc func ClickedRestartButton() {
        
        self.restartButton.image = nil
        self.resultPic.image = nil
        self.picFirstSetting()
        self.ChoosedDoor.text = gameExplainText
        
        
    }
    
    
    func picFirstSetting() {
        
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(self.picFirst))
        self.firstPic.addGestureRecognizer(tapGesture1)
        self.firstPic.isUserInteractionEnabled = true
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.picSecond))
        self.secondPic.addGestureRecognizer(tapGesture2)
        self.secondPic.isUserInteractionEnabled = true
        
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(self.picThird))
        self.thirdPic.addGestureRecognizer(tapGesture3)
        self.thirdPic.isUserInteractionEnabled = true
        
        self.picMakeDoor()
        
    }
    
    
    
    func picMakeDoor() {
        
        let image = UIImage(named: "door.png")
        
        self.firstPic.image = image
        self.secondPic.image = image
        self.thirdPic.image = image
        
    }
    
    
    func firstImage() -> UIImage? {
        let image = UIImage(named: "Monster1.png")
        return image
    }
    func secondImage() -> UIImage? {
        let image = UIImage(named: "Monster2.png")
        return image
    }
    func coinImage() -> UIImage? {
        let image = UIImage(named: "coin.png")
        return image
    }
    func defeatImage() -> UIImage? {
        let image = UIImage(named: "defeat.png")
        return image
    }
    func winImage() -> UIImage? {
        let image = UIImage(named: "win.png")
        return image
    }
 }
