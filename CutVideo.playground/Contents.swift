//: Playground - noun: a place where people can play

import UIKit
import AVKit
import PlaygroundSupport

let pgDir = playgroundSharedDataDirectory
let fileURL = pgDir.appendingPathComponent("input.mp4")
let asset = AVAsset(url: fileURL)
var vidLength: CMTime = asset.duration
var seconds: Double = CMTimeGetSeconds(vidLength)
var requiredFramesCount = Int((seconds * 10))
var step = Int((vidLength.value / Int64(requiredFramesCount)))
var value: Int = 0
for i in 0..<requiredFramesCount {
    let imageGenerator = AVAssetImageGenerator(asset: asset)
    imageGenerator.requestedTimeToleranceAfter = kCMTimeZero
    imageGenerator.requestedTimeToleranceBefore = kCMTimeZero
    let time: CMTime = CMTimeMake(Int64(value), vidLength.timescale)
    let imageRef = (try? imageGenerator.copyCGImage(at: time, actualTime: nil))
    let thumbnail = UIImage(cgImage: imageRef!)
    let filename = "/Users/glebkarpushkin/Downloads/videoImages/frame_\(i).png"
    let pngPath: URL = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent(filename)
    let image = UIImagePNGRepresentation(thumbnail)
    try! image?.write(to: URL(string: "\(pgDir)/images/frame_\(i).png")!)
    value += Int(step)
}

