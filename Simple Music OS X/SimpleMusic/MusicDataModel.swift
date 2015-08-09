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
    var playQueue: [AVAudioPlayer] = [AVAudioPlayer]() //The Play queue for the songs
    var audioFileNames = [String]() //An array whose elements are the names of the audio files
    var audioFileAlbumNames = [String]()
    var audioFileArtistNames = [String]()
    var audioFileURLs: [NSURL] = [NSURL]()
    var currentIndex: Int = 0
    
    
    override init()
    {
        for url in audioFileURLs
        {
            println("Filepath: \(url)")
            playQueue.append(AVAudioPlayer(contentsOfURL: url, error: nil))
        }
        if playQueue.count > 0
        {
            player = playQueue[currentIndex]
        }
    }
    
    func previousTrack()
    {
        if currentIndex + 1 != playQueue.endIndex
        {
            player.pause()
            
            println("End Index: \(playQueue.endIndex)")
            println("Number of items in queue: \(playQueue.count)")
            currentIndex++
            
            player = playQueue[currentIndex]
            player.play()
        }
        else
        {
            println("No previous songs")
            println(currentIndex)
        }
    }
    
    func nextTrack()
    {
        if currentIndex == 0
        {
            println("No songs lefts bro")
            println(currentIndex)
        }
        
        else if currentIndex > 0
        {
            player.pause()
            println("Invoked else if statement")
            
            currentIndex--
            
            player = playQueue[currentIndex]
            player.play()
        }
    }
    
    func changeCurrentIndex(index: Int)
    {
        println("Invoked changeCurrentIndex. The index is: \(index)")
        if player != nil
        {
            player.stop()
            println("Player is not nil bruh.")
        }
        println(currentIndex)
        currentIndex = index
        
        player = playQueue[currentIndex]
    }
    
}
