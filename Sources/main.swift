import Foundation
import Rainbow
import BencodingKit

let fileHandle: FileHandle
if isatty(STDIN_FILENO) != 0 {
    let u = URL(fileURLWithPath: CommandLine.arguments[1])
    fileHandle = try FileHandle(forReadingFrom: u)
} else {
    fileHandle = FileHandle.standardInput
}

let DELIMETER_COLOR = Color.red


let topLevel = try Bencoding.object(from: try fileHandle.readToEnd()!)

func display(_ obj: Any, indent: String = "") {
    switch obj {
    case let x as Dictionary<String, Any>:
        print("\(indent)\("d".red)")
        for (key, value) in x.sorted(by: { $0.key < $1.key }) {
            display(key, indent: indent + "  ")
            display(value, indent: indent + "  ↳ ".bold)
        }
        print("\(indent)\("e".red)")
    case let x as Array<Any>:
        print("\(indent)\("l".blue)")
        for element in x {
            display(element, indent: indent + "  ")
        }
        print("\(indent)\("e".blue)")
    case let x as Int:
        print("\(indent)\("i".green)\(x)\("e".green)")
    case let x as String:
        print("\(indent)\("\(x.count):".yellow)\(x)")
    default:
        print("\(indent)Unknown type")
    }
}

display(topLevel)


/*
▿ TorrentFileKit.TorrentFileV2
  - announce: "http://example.com/announce"
  ▿ info: TorrentFileKit.TorrentFileV2.InfoDictionary
    - name: "v2.txt"
    - pieceLength: 65536
    - metaVersion: 2
    ▿ fileTree: 1 element
      ▿ TorrentFileKit.TorrentFileV2.InfoDictionary.MultipleFileInfo
        - length: 14
        ▿ path: 1 element
          - "v2.txt"
        ▿ piecesRoot: 32 bytes
          - count: 32
          ▿ pointer: 0x00006000034a8480
            - pointerValue: 105553171481728
          ▿ bytes: 32 elements
            - 217
            - 1
            - 76
            - 70
            - 36
            - 132
            - 74
            - 165
            - 186
            - 195
            - 20
            - 119
            - 61
            - 107
            - 104
            - 154
            - 212
            - 103
            - 250
            - 78
            - 29
            - 26
            - 80
            - 161
            - 184
            - 169
            - 157
            - 90
            - 149
            - 247
            - 47
            - 245
*/
