//
//  ViewController.swift
//  SimpleMusic
//
//  Created by Atharva Vaidya on 02/08/15.
//  Copyright © 2015 Atharva Vaidya. All rights reserved.
//

import Cocoa
import Foundation
import AVFoundation
class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate
{
    let musicData = MusicData()

    @IBAction func volumeSliderClicked(sender: NSSlider)
    {
        musicData.player.volume = sender.floatValue
    }
    @IBOutlet weak var tableView: NSTableView!
    
    //@IBOutlet weak var playPauseButton: NSButton!
    
    @IBAction func playPauseButton(sender: NSButton)
    {
        
        let isPlayingMusic = musicData.player.playing
        if isPlayingMusic == true
        {
            musicData.player.pause()
            sender.title = "Play"
        }
        else
        {
            musicData.player.play()
            sender.title = "Pause"
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.clickedRow
    }

    override var representedObject: AnyObject?
        {
        didSet {
        // Update the view, if already loaded.
        }
    }
    func numberOfRowsInTableView(tableView: NSTableView) -> Int
    {
        println("Got to number of rows")
        return musicData.playQueue.count
        
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView?
    {
        let cellView: NSTableCellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: self) as! NSTableCellView
        println("Got to the func")
        if tableColumn?.identifier != nil
        {
            if tableColumn?.identifier == "Name"
            {
                cellView.textField?.stringValue = musicData.audioFileNames[row]
                return cellView
            }
            
            if tableColumn?.identifier == "Duration"
            {
                
                var duration = NSInteger(musicData.playQueue[row].duration)
                var seconds = duration % 60
                var min = (duration / 60) % 60
                
                
                if seconds < 10
                {
                    cellView.textField?.stringValue = "\(min):0\(seconds)"
                    println("\(min):0\(seconds)")
                }
                else
                {
                    cellView.textField?.stringValue = "\(min):\(seconds)"
                    println("\(min):\(seconds)")
                }
            }
            
            if tableColumn?.identifier == "Album"
            {
                cellView.textField?.stringValue = "\(musicData.audioFileAlbumNames[row])"
            }
            
            if tableColumn?.identifier == "Artist"
            {
                cellView.textField?.stringValue = "\(musicData.audioFileArtistNames[row])"
            }

        }
        return cellView
    }
    
    @IBAction func addSongByReference(sender: NSMenuItem)
    {
        let openDialog = NSOpenPanel()
        openDialog.canChooseFiles = true
        openDialog.canChooseDirectories = true
        openDialog.directoryURL = nil
        openDialog.allowedFileTypes = ["mp3"]
        openDialog.canCreateDirectories = true
        openDialog.allowsMultipleSelection = true
        if openDialog.runModal() == NSFileHandlingPanelOKButton
        {
            var filePaths = openDialog.URLs as! [NSURL]
            println(filePaths)
            for filePath in filePaths
            {
                musicData.audioFileURLs.append(filePath)
              
                var asset: AVAsset = AVURLAsset.assetWithURL(filePath) as! AVAsset
                
                var metadataForAsset: SMetadata = SMetadata()
                
                metadataForAsset.metaDataForAVAsset(asset)
                
                let metadataTitle = metadataForAsset.metaDataForAVAsset(asset)[0]
                println("\(metadataTitle)")
                
                var titles = AVMetadataItem.metadataItemsFromArray(asset.commonMetadata, withKey: AVMetadataCommonKeyTitle, keySpace: AVMetadataKeySpaceCommon)
                var title = titles[0] as! AVMetadataItem
                
                var albums = AVMetadataItem.metadataItemsFromArray(asset.commonMetadata, withKey: AVMetadataCommonKeyAlbumName, keySpace: AVMetadataKeySpaceCommon)
                var album = albums[0] as! AVMetadataItem
                
                var artists = AVMetadataItem.metadataItemsFromArray(asset.commonMetadata, withKey: AVMetadataCommonKeyArtist, keySpace: AVMetadataKeySpaceCommon)
                var artist = artists[0] as! AVMetadataItem
                
                musicData.audioFileNames.append("\(title.value())")
                musicData.audioFileAlbumNames.append("\(album.value())")
                musicData.audioFileArtistNames.append("\(artist.value())")
                
            }
            println(musicData.audioFileNames)
            for url in musicData.audioFileURLs
            {
                println("Filepath: \(url)")
                musicData.playQueue.append(AVAudioPlayer(contentsOfURL: url, error: nil))
            }
            
            println(musicData.playQueue)
            tableView.reloadData()
        }
    }
    
    func tableViewSelectionDidChange(notification: NSNotification)
    {
        selectedSong()
    }
    
    
    func selectedSong()
    {
        let selectedRow = self.tableView.selectedRow
        println("The selected row: \(selectedRow)")
        if selectedRow >= 0 && selectedRow < self.musicData.playQueue.count
        {
            musicData.changeCurrentIndex(selectedRow)
            musicData.player.play()
            println("Current musicData Index: \(musicData.currentIndex)")
            //playPauseButton.title = "Pause"
        }
    }
    @IBAction func previousTrack(sender: NSButton)
    {
        
        musicData.previousTrack()
        
    }
    
    
    @IBAction func nextTrack(sender: NSButton)
    {
        
        musicData.nextTrack()
      
    }
    
    @IBAction func openByLink(sender: NSMenuItem)
    {
        
    }

}

