//
//  AppParser.swift
//  app-parser
//
//  Created by Alex Guretzki on 17/02/2023.
//

import Foundation
import ZIPFoundation

public enum Inspector {
    
    public static func inspect(appAtUrl sourceURL: URL) async throws -> AppInfo {
        
        let fileManager = FileManager()
        var destinationURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
        destinationURL.appendPathComponent("decompressed")
        
        print("Deleting existing folder \(destinationURL.absoluteString)")
        if fileManager.fileExists(atPath: destinationURL.path()) {
            try fileManager.removeItem(atPath: destinationURL.path())
        }
        
        print("Extracting ipa to \(destinationURL.absoluteString)")
        
        try fileManager.createDirectory(at: destinationURL, withIntermediateDirectories: true, attributes: nil)
        try fileManager.unzipItem(at: sourceURL, to: destinationURL)
        
        let itunesMetadataPlistPath = destinationURL.appending(component: "iTunesMetadata.plist")
        let itunesMetadataPlist = try plist(fromUrl: itunesMetadataPlistPath)
        
        let bundleDisplayName = itunesMetadataPlist["bundleDisplayName"] as! String
        let bundleShortVersionString = itunesMetadataPlist["bundleShortVersionString"] as! String
        let bundleVersion = itunesMetadataPlist["bundleVersion"] as! String
        
        let payloadDirectory = destinationURL.appending(components: "Payload")
        let appDirectory = payloadDirectory.appending(component: try fileManager.contentsOfDirectory(atPath: payloadDirectory.path()).first!).path()
        
        let filePaths = try fileManager.getAllFilePaths(
            fromDirectory: appDirectory,
            appDirectoryPath: appDirectory
        )
        
        return .init(
            name: bundleDisplayName,
            marketingVersion: bundleShortVersionString,
            bundleVersion: bundleVersion,
            filePaths: filePaths
        )
    }
    
    static func plist(fromUrl fileUrl: URL) throws -> [String: Any] {
        let data = try Data(contentsOf: fileUrl)
        return try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! [String: Any]
    }
}

extension FileManager {
    
    func getAllFilePaths(fromDirectory directoryPath: String, appDirectoryPath: String) throws -> [String] {
        
        var filePaths = [String]()
        
        for fileName in try contentsOfDirectory(atPath: directoryPath) {
            
            var filePath = directoryPath + "/" + fileName
            var isDir : ObjCBool = false
            if fileExists(atPath: filePath, isDirectory:&isDir) {
                if isDir.boolValue {
                    filePaths += try getAllFilePaths(fromDirectory: filePath, appDirectoryPath: appDirectoryPath)
                } else {
                    filePath.trimPrefix(appDirectoryPath)
                    filePaths += [filePath]
                }
            }
        }
        
        return filePaths
    }
}
