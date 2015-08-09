//
//  SMetadata.swift
//  SimpleMusic
//
//  Created by Atharva Vaidya on 09/08/15.
//  Copyright (c) 2015 Atharva Vaidya. All rights reserved.
//

import Cocoa
import AVFoundation

class SMetadata: AVMetadataItem
{
    var title: String!
    var artist: String!
    var album: String!
    
    func metaDataForAVAsset(asset: AVAsset) -> [String]
    {
        var metaTitle = AVMetadataItem.metadataItemsFromArray(asset.commonMetadata, withKey: AVMetadataCommonKeyTitle, keySpace: AVMetadataKeySpaceCommon)
        var titles = metaTitle[0] as! AVMetadataItem
        
        title = "\(titles.value())"
        
        var metaArtist = AVMetadataItem.metadataItemsFromArray(asset.commonMetadata, withKey: AVMetadataCommonKeyArtist, keySpace: AVMetadataKeySpaceCommon)
        var artists = metaArtist[0] as! AVMetadataItem
        
        artist = "\(artists.value())"
        
        var metaAlbum = AVMetadataItem.metadataItemsFromArray(asset.commonMetadata, withKey: AVMetadataCommonKeyAlbumName, keySpace: AVMetadataKeySpaceCommon)
        var albums = metaAlbum[0] as! AVMetadataItem
        
        album = "\(albums.value())"
        
        return [title, artist, album]
    }
}
