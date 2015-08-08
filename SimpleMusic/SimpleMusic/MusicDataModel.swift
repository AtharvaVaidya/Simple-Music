//
//  MusicModel.swift
//  SimpleMusic
//
//  Created by Atharva Vaidya on 02/08/15.
//  Copyright © 2015 Atharva Vaidya. All rights reserved.
//



import Foundation
import AVFoundation
import CoreAudio

class MusicData: NSObject
{
    
    var player: AVAudioPlayer! //The player playing the current song.
    var playQueue: [AVAudioPlayer]! //The Play queue for the songs
    var audioFileNames = ["1-04 Sooner Or Later"] //An array whose elements are the names of the audio files
    var audioFileURLs: [NSURL] = [NSURL]()
    var currentIndex: Int = 0
    var isPreviousTrackLegal = false
    var isNextTrackLegal = false
    
    override init()
    {
        //Associate the filenames with the files and add them to the playQueue array
        playQueue = audioFileNames.map
        { filename in
                let url = NSBundle.mainBundle().URLForResource(filename, withExtension: "mp3")
                return AVAudioPlayer(contentsOfURL: url, error: nil)
        }
        for url in audioFileURLs
        {
            println("Filepath: \(url)")
            playQueue.append(AVAudioPlayer(contentsOfURL: url, error: nil))
        }
        player = playQueue[currentIndex]
    }
    
    func play()
    {
        if !playQueue.isEmpty
        {
            player.play()
        }
        
    }
    
    func pause()
    {
        if !playQueue.isEmpty
        {
            player.pause()
        }
    }
    
    var musicLibrary: [NSURL] = [NSURL]()
    
    func addToMusicLibrary(urls: Array<AnyObject>)
    {
        for url in urls
        {
            
            musicLibrary.append(url as! NSURL)
          
        }
    }
    
    func previousTrack()
    {
        if currentIndex >= 0 && playQueue.count >= 2
        {
            isPreviousTrackLegal = true
            currentIndex++
            player = playQueue[currentIndex]
        }
        else
        {
            println("No previous songs")
            isPreviousTrackLegal = false
        }
    }
    
    func nextTrack()
    {
        if currentIndex == 0
        {
            println("No songs lefts bro")
            isNextTrackLegal = false
        }
        
        else if currentIndex > 0
        {
            isNextTrackLegal = true
            println("Invoked else if statement")
            currentIndex--
            player = playQueue[currentIndex]
        }
    }
    
    func changeCurrentIndex(index: Int)
    {
        currentIndex = index
        player = playQueue[currentIndex]
    }
    
}
