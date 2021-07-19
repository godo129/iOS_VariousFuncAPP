//
//  MusicViewController.swift
//  Widget_projects
//
//  Created by 소프트웨어컴퓨터 on 2021/06/06.
//

import UIKit
import AVFoundation


struct album {
    var albumname : String
    var albumimage : String
    var singer : String
    var songfile : String
}

class MusicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet var musicPlayer: UIView!
    
    var player: AVPlayer!
    
    
    var playerItem: AVPlayerItem?
    var timeObserverToken: Any?
    
    var playIndex = 0
    
    
    // 앨범 정보 구조화
    var songData = [album(albumname: "노래", albumimage: "1.jpg", singer: "Zion.T", songfile: "1"),
                    album(albumname: "Heat Waves", albumimage: "2.jpg", singer: "Glass Animals", songfile: "2"),
                    album(albumname: "Pink Lemonade", albumimage: "3.jpg", singer: "Jonny Stimson", songfile: "3"),
                    album(albumname: "Sincerity Is Scary", albumimage: "4.jpg", singer: "The 1975", songfile: "4"),
                    album(albumname: "거리에서", albumimage: "5.jpg", singer: "성시경", songfile: "5")]
    

    // 개체들 처리
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var cover_shadow: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var preButton: UIButton!
    @IBOutlet weak var songText: UILabel!
    @IBOutlet weak var singerText: UILabel!
    @IBOutlet weak var volumeShow: UISlider!
    @IBOutlet weak var progress: UISlider!
    @IBOutlet weak var totalText: UILabel!
    @IBOutlet weak var currentText: UILabel!
    
    @IBOutlet weak var musicLists: UITableView!
    
    // 곡 정보 나오게 하기
    func playinformation() {
        songText.text = songData[playIndex].albumname
        singerText.text = songData[playIndex].singer
    }
    
    // 노래 재생
    func playmusic() {
        
        // 인덱스 처리
        if playIndex < songData.count {
            
            if playIndex < 0 {
                playIndex = songData.count - 1
            }
            // 노래 불러오기
            
            UserDefaults.standard.setValue(playIndex, forKey: "nowIndex")
            
            if let songurl = Bundle.main.url(forResource: songData[playIndex].songfile, withExtension: "mp3") {
                print(playIndex)
                player = AVPlayer(url: songurl)
                playerItem = AVPlayerItem(url: songurl)
                
                

                
            } else {
                print("실패")
            }
                
            
            // 사진 불러오기
            cover.image = UIImage(named: songData[playIndex].albumimage)
            
            addPeriodicTimeObserver()
            progress.value = 0
            player.play()
            
            
            
        } else { // 마지막 인덱스 다음은 처음으로
            playIndex = 0
            playmusic()
            
        }
    }
    
    
  
    
    func addPeriodicTimeObserver() {
            
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
            
            
            // 시간 표시
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: time, queue: .main ) {[weak self] time in
            let songcurrent = self!.player.currentTime().seconds
            let songcurrentInt = Int(songcurrent)
            let min1 = Int(songcurrentInt / 60)
            let sec1 = songcurrentInt - 60*min1
            self!.currentText.text = String(format: "%02d:%02d", min1,sec1)
                
                
            let duration = self!.playerItem?.asset.duration
            let songtotal = CMTimeGetSeconds(duration!)
            let songtotalInt = Int(songtotal)
            let min2 = Int(songtotal / 60)
            let sec2 = songtotalInt - 60*min2
            self!.totalText.text = String(format: "%02d:%02d", min2,sec2)
                
                
                
            let currenttotal: Float = Float(songcurrent/songtotal)
            self!.progress.value = currenttotal
            
      
            
            //UserDefaults.standard.setValue(songcurrentInt, forKey: "songCurrent")
           
        
            
            }
        
        
            
            
            }
    
 
    
    
    
    // 재생 시간 다 끝남
    func removePeriodicTimeObserver()  {
        if let timeObserverToken = timeObserverToken {
            player.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
            
            
            
            
        }
    }
    
   
    
    @IBAction func dissmissMusic(_ sender: Any) {
        presentingViewController?.dismiss(animated: true)
        
        
    }
    
    
    // 노래 리스트
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "musicItem") else {
            fatalError()
        }
        
        cell.textLabel?.text = self.songData[indexPath.row].albumname + " - "+self.songData[indexPath.row].singer
        playIndex = indexPath.row
        
        return cell
    }
    
    // 클릭시 클릭한 음악 재생
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.playIndex = indexPath.row
        self.playmusic()
        playButton.setImage(UIImage(named: "pause"), for: .normal)
        musicLists.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        musicLists.delegate = self
        musicLists.dataSource = self
        
        
        
        
        // 백그라운드 재생
        //do {
         //   try AVAudioSession.sharedInstance().setCategory(.playback, mode:  .default)
          //  try AVAudioSession.sharedInstance().setActive(false)
         //   print("aa")
            
      //  } catch {
       //     print(error.localizedDescription)
      //  }
    
        
        
        cover.image = UIImage(named: songData[playIndex].albumimage)
        

        
        // 재생된 노래 번호 기억
        
        let haveIndex = UserDefaults.standard.integer(forKey: "nowIndex")
        playIndex = haveIndex
        

        
        
        // 노래 현재 재생 시간 가져오기
        //let songcurrnetNow = UserDefaults.standard.integer(forKey: "songCurrent")
        //let songNow = CMTimeMake(value: Int64(songcurrnetNow), timescale: 2)
        //let songNow = CMTimeMake(value: Int64(0), timescale: 1)

        playButton.setImage(UIImage(named: "play"), for: .normal)
       
        
        playmusic()
        player.pause()
        playinformation()
        
        volumeShow.value = 0.4
        
        
        
        // 백그라운드에서 버튼 상태 저장
        //if let ButtonStatus = UserDefaults.standard.string(forKey: "buttonStatus") {
            
           // if ButtonStatus == "play" {
             //   playButton.setImage(UIImage(named: "pause"), for: .normal)
                //player.seek(to: songNow)
                //addPeriodicTimeObserver()
                
               
                
           // } else {
              //  playButton.setImage(UIImage(named: "play"), for: .normal)
               // progress.value = songProgress
                //player.seek(to: songNow)
                //addPeriodicTimeObserver()
                
                
             //   player.pause()
                
          //  }
            
      //  } else {
       // playButton.setImage(UIImage(named: "play"), for: .normal)
        //    player.pause()
            //addPeriodicTimeObserver()

            
      //  }
            

        
        
        // 재생 끝나면 자동으로 처리해주도록
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: .main ) { (_) in
            self.removePeriodicTimeObserver()
            self.playIndex += 1
            self.playmusic()
            self.playinformation()

        }
        
        
        

        // Do any additional setup after loading the view.
    }
   
   
    
   
    
    @IBAction func playbtn(_ sender: Any) {
        
        //playinformation()
        
        // 재생 버튼 눌렀을 때
        if player.rate == 0 {
            playButton.setImage(UIImage(named: "pause"), for: .normal)
            player.play()
     
                
                // 데이터 저장
            //UserDefaults.standard.set("play", forKey: "buttonStatus")
            
           
            
                } else {  // 정지 버튼 눌렀을 때
            playButton.setImage(UIImage(named: "play"), for: .normal)
            
                player.pause()
            
            //UserDefaults.standard.set("Pause", forKey: "buttonStatus")
            
        }
    }
    
    @IBAction func nextbtn(_ sender: Any) {
     
        playIndex += 1
        playmusic()
        playinformation()
        
        
        
           }
    
    @IBAction func prebtn(_ sender: Any) {
        
        removePeriodicTimeObserver()
        
        playIndex -= 1
        playmusic()
        playinformation()
        
    }
    
    
    @IBAction func volumeBtn(_ sender: Any) {
        let volume = volumeShow.value
        player.volume = volume
    }
    
    
    @IBAction func progressBtn(_ sender: Any) {
        let songcurrent = progress.value
        
        // 전체 시간
        let duration = self.playerItem?.asset.duration
        let songtotal = CMTimeGetSeconds(duration!)
        let songtotalFloat = Float(songtotal)
        
        let songhahqa = Int(songtotalFloat * songcurrent)
        let time = CMTime(value: CMTimeValue(songhahqa), timescale: 1)
        
        // 시간 초기화 방지
        player.seek(to: time)
        
    }
    
    
    
    
    
    

}
