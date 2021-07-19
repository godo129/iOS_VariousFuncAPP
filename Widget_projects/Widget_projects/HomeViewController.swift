

import UIKit
import AVFoundation

class HomeViewController: UIViewController {
    

    @IBOutlet weak var firtFrame: UIImageView!
    @IBOutlet weak var secondFrame: UIImageView!
    @IBOutlet weak var thirdFrame: UIImageView!
    @IBOutlet weak var fourthFrame: UIImageView!
    
    @IBOutlet weak var pointText: UILabel!
    
    @IBAction func goMusic(_ sender: UIButton) {
        let musicVC = storyboard?.instantiateViewController(withIdentifier: "MusicVC")
        musicVC?.modalTransitionStyle = .coverVertical
        present(musicVC!, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func goGame(_ sender: UIButton) {
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "GameVC")
        VC?.modalPresentationStyle = .fullScreen
        VC?.modalTransitionStyle = .flipHorizontal
        present(VC!, animated: true, completion: nil)    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        //음악 재생 안되게 
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode:  .default)
            try AVAudioSession.sharedInstance().setActive(false)
            print("aa")
            
        } catch {
            print(error.localizedDescription)
        }
        
        UpdateScore()
        
        
        // 이미지 처리
        self.firtFrame.image = generateThumbnail(url: "Seoul")
        self.secondFrame.image = generateThumbnail(url: "LA")
        self.thirdFrame.image = generateThumbnail(url: "Paris")
        self.fourthFrame.image = generateThumbnail(url: "Tokyo")
        
        
        // 그림뷰 터치 가능하게
        makePicLikeButton()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    // 뷰 다시 나올 때 다시 불러오기
    override func viewWillAppear(_ animated: Bool) {
        UpdateScore()
    }
    
    
    // 포인트 처리
    func UpdateScore(){
        
        
        // 데이터 불러오기,,, 초기에 포인트가 없을 때 처리
        if let numString = UserDefaults.standard.string(forKey: "Points") {
            
            
            // 데이터 저장
            UserDefaults.standard.set(numString, forKey: "Points")
            
            
            self.pointText.text = numString + " point"
            
        }else  {
            
            
            UserDefaults.standard.set(4, forKey: "Points")
            
            let numString = UserDefaults.standard.string(forKey: "Points")
            
            self.pointText.text = numString! + " point"
            
            
        }
        // 데이터 저장
        //UserDefaults.standard.set(numString, forKey: "Points")
        
        
        //self.pointText.text = numString! + " point"
    
    }
    
    // 썸네일 이미지 만들기
    func generateThumbnail(url: String) -> UIImage? {
        do {
            guard let Url = Bundle.main.url(forResource: url, withExtension: "mp4") else { return nil }
            let asset = AVURLAsset(url: Url,options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let timestamp = CMTime(seconds: 10, preferredTimescale: 60)
            let cgImage = try imgGenerator.copyCGImage(at: timestamp, actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            return thumbnail
            
        } catch let error {
            return nil
        }
    }
    
    
  
    
    // 그림 클릭 가능하게
    func makePicLikeButton() {
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(self.SeoulVC))
        self.firtFrame.addGestureRecognizer(tapGesture1)
        self.firtFrame.isUserInteractionEnabled = true
        
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(self.LA_VC))
        self.secondFrame.addGestureRecognizer(tapGesture2)
        self.secondFrame.isUserInteractionEnabled = true
        
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(self.ParisVC))
        self.thirdFrame.addGestureRecognizer(tapGesture3)
        self.thirdFrame.isUserInteractionEnabled = true
        
        let tapGesture4 = UITapGestureRecognizer(target: self, action: #selector(self.TokyoVC))
        self.fourthFrame.addGestureRecognizer(tapGesture4)
        self.fourthFrame.isUserInteractionEnabled = true
        
    }
    
    @IBAction func helpButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "이 어플은 세계 여러 도시를 드라이브하면서 찍은 영상을 즐길 수 있는 어플입니다. 그 도시의 현재 날씨 정보 또한 제공하여 몰입감을 높였습니다. \n또한 음악과 웹 서핑 기능도 구현해 놓았습니다. 해당 기능들은 우측 상단에 버튼을 통해 이용할 수 있습니다. \n 마지막으로 각 뷰에 들어가실 때마다 1포인트가 필요하니 주의해 주시기 바랍니다. 포인트는 게임을 통해서 얻을 수 있습니다. ", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert,animated: true)    }
    
 
    
    
    
    // 포인트 사용
    func pointControl() -> Bool{
        
        let pointValue = UserDefaults.standard.integer(forKey: "Points")
        
        if pointValue <= 0 {
            
            let alert = UIAlertController(title: "포인트가 부족합니다. \n게임을 통해서 포인트를 얻어보세요. ", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert,animated: true)
            return false
            
            
        } else {
            
            UserDefaults.standard.setValue(pointValue-1, forKey: "Points")
            return true
            
        }
        
        
    }
    
    
    @objc func SeoulVC(){
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "SeoulVC")
        VC?.modalPresentationStyle = .fullScreen
        VC?.modalTransitionStyle = .flipHorizontal
        
        if pointControl() {
            present(VC!, animated: true, completion: nil)
            
        }
        
    }
    
    @objc func LA_VC(){
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "LAVC")
        VC?.modalPresentationStyle = .fullScreen
        VC?.modalTransitionStyle = .flipHorizontal
        
        if pointControl() {
        present(VC!, animated: true, completion: nil)
        }
        
        
    }
    
    @objc func ParisVC(){
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "ParisVC")
        VC?.modalPresentationStyle = .fullScreen
        VC?.modalTransitionStyle = .flipHorizontal
        
        if pointControl() {
        present(VC!, animated: true, completion: nil)
        }
        
        
    }
    
    @objc func TokyoVC(){
        
        let VC = storyboard?.instantiateViewController(withIdentifier: "TokyoVC")
        VC?.modalPresentationStyle = .fullScreen
        VC?.modalTransitionStyle = .flipHorizontal
        
        if pointControl() {
        present(VC!, animated: true, completion: nil)
        }
        
    }

    
    
}
