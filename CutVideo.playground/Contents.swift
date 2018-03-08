//: Playground - noun: a place where people can play

import UIKit
import AVKit
import PlaygroundSupport

// Create folder manually: /Users/{USER}/Documents/Shared\ Playground\
// Also create images folder inside

let playGorundDirectory = playgroundSharedDataDirectory

let fileURL = playGorundDirectory.appendingPathComponent("input.mp4")
let asset = AVAsset(url: fileURL)
var vidLength: CMTime = asset.duration
var seconds: Double = CMTimeGetSeconds(vidLength)

var requiredFramesCount = Int((seconds * 24))

var step = Int((vidLength.value / Int64(requiredFramesCount)))
var value: Int = 0

func iterate() {
    for i in 0..<requiredFramesCount {
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.requestedTimeToleranceAfter = kCMTimeZero
        imageGenerator.requestedTimeToleranceBefore = kCMTimeZero
        let time: CMTime = CMTimeMake(Int64(value), vidLength.timescale)
        let imageRef = (try? imageGenerator.copyCGImage(at: time, actualTime: nil))
        let thumbnail = UIImage(cgImage: imageRef!)
        let image = UIImagePNGRepresentation(thumbnail)
        guard let urlToSave = URL(string: "\(playGorundDirectory)/images/frame_\(i).png") else {return}
        do {
            try  image?.write(to: urlToSave)
        } catch {
            print(error)
        }
        value += Int(step)
    }
}

iterate()
