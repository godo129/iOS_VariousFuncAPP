//
//  ViewController.swift
//  Widget_projects
//
//  Created by 소프트웨어컴퓨터 on 2021/06/04.
//

import UIKit
import AVFoundation




class ViewController: UIViewController {
    
    

 
    
    @IBOutlet weak var weatherText: UILabel!
    
    let weatherAPI_URL = "https://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=6133de20ded927279482a432889cab72"
    
    
    
    
    @IBAction func goMusic(_ sender: UIButton) {
        let musicVC = storyboard?.instantiateViewController(withIdentifier: "MusicVC")
        musicVC?.modalTransitionStyle = .coverVertical
        present(musicVC!, animated: true, completion: nil)
    }
    @IBAction func goWeb(_ sender: UIButton) {
        let webVC = storyboard?.instantiateViewController(withIdentifier: "WebVC")
        webVC?.modalTransitionStyle = .coverVertical
        present(webVC!, animated: true, completion: nil)
    }
    
   
    @IBAction func backButton(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
        
    }
    
 

    private var observers: (player: NSObjectProtocol, willEnterForeground: NSObjectProtocol, boundsObserver: NSKeyValueObservation)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()

        let path = Bundle.main.path(forResource: "Seoul", ofType: "mp4")!
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        player.play()

        // 재생 레이어 만들기
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.zPosition = -2
        view.layer.insertSublayer(playerLayer, at: 0)

        
        // 재생 끝났을 때 재생
        let playerObserver = NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main) { [weak playerLayer] _ in
            playerLayer?.player?.seek(to: CMTime.zero)
                playerLayer?.player?.play()
        }
        
        // 어플이 백그라운드에서 돌아 왔을 때 재생

        let willEnterForegroundObserver = NotificationCenter.default.addObserver(
            forName: UIApplication.willEnterForegroundNotification,
            object: nil,
            queue: .main) { [weak playerLayer] _ in
                playerLayer?.player?.play()
        }

        // 화면 회전시 크기 조정
        let boundsObserver = view.layer.observe(\.bounds) { [weak playerLayer] view, _ in
            DispatchQueue.main.async {
                playerLayer?.frame = view.bounds
               
            }
        }

        observers = (playerObserver, willEnterForegroundObserver, boundsObserver)
    }
    
   
    func getData() {
        
        if let url = URL(string: weatherAPI_URL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let data = data {
                    //print(JSONdata,response!)
                    let dataString = String(data: data, encoding: .utf8)
                    
                    
                    
                    // Json 데이터 열거
                    let Arr = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    let name = Arr["name"]
                    let nameString = name! as! String
                    
                    
                    let temp = ((Arr["main"] as! [String:Any])["temp"] as? NSNumber)?.floatValue ?? 0
                    let temp2 = temp.rounded() - 273

                    let tempString = String(temp2) + "°"

                    
                    let weather = (Arr["weather"] as! [[String:Any]])[0]["main"]
                    let weatherString = weather! as! String
                    
                    let icon = (Arr["weather"] as! [[String:Any]])[0]["icon"] as! String
                    let iconUrl = "http://openweathermap.org/img/wn/" + icon + ".png"
                    
         
                    
                    self.inputImageToLabel(weatherInfos: nameString + ": " + tempString  ,icon: iconUrl)
            
                    
                    
                }
            }
            
            task.resume()
        }
        
        
    }
    
    func weatherInformation(name: String, temp: String) -> String {
        
        return name + temp
    }
 
    func inputImageToLabel(weatherInfos: String, icon: String) {
        let imageAttachment = NSTextAttachment()
        
        // 그림 파일 든 url 데이터 처리
        let imageData = try! Data(contentsOf: URL(string: icon)!)
        imageAttachment.image = UIImage(data: imageData)
        // 이미지 크기,포지션 설정
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        // 이미지 NSA스트링 요소로 변환
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        
        // 변경 가능한 요소
        let weatherInfoText = NSMutableAttributedString(string: "")
        //이미지 넣음
        weatherInfoText.append(attachmentString)
        //텍스트 요소
        let weatherInfo = NSAttributedString(string: weatherInfos)
        //텍스트 넣음
        weatherInfoText.append(weatherInfo)
        //정렬

        //레이블에 내용 뿌려주기
        self.weatherText.attributedText  = weatherInfoText
        
        self.weatherText.textColor = .systemBlue

}

}
