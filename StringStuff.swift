// This program reads the length of a,
// string determining the max run.

//
//  Created by Sarah Andrew

//  Created on 2023-03-04

//  Version 1.0

//  Copyright (c) 2023 Sarah. All rights reserved.
import Foundation

// This function calculates the longest run
// in a string & returns it to main.
func maxRun(strRun: String) -> Int {
    // Declare variables.
    var maxCount = 0
    var currentCount = 1
    
    // Usage of loop to access each element.
    for counter in 1..<strRun.count {
        // Checks to see if the current letter is the
        // same as the previous one.
        if strRun[strRun.index(strRun.startIndex, offsetBy: counter)] ==
            strRun[strRun.index(strRun.startIndex, offsetBy: counter - 1)] {
            // Increment current count.
            currentCount += 1
        } else {
            // If not, update maxCount & reset the current count.
            if currentCount > maxCount {
                maxCount = currentCount
            }
            currentCount = 1
        }
    }

    // Update max count after loop ends.
    if currentCount > maxCount {
        // Set max count equal to current count.
        maxCount = currentCount
    }
    // Return the maxCount
    return maxCount
}

// Define input & output paths.
let inputFile = "input.txt"
let outputFile = "output.txt"

// Usage of file handle method to locate files,
// as well as opening input for file reading.
do {
    // Open input file for reading.
    guard let input = FileHandle(forReadingAtPath: inputFile) else {
        print("Error: cannot access input file for opening.")
        exit(1)
    }

    // Open output file for writing.
    guard let output = FileHandle(forWritingAtPath: outputFile) else {
        print("Error: cannot access output file for opening.")
        exit(1)
    }
    // Read context for file.
    let inputData = input.readDataToEndOfFile()

    // Convert data to a string.
    guard let inputString = String(data: inputData, encoding: .utf8) else {
        print("Error: Cannot convert input data to string.")
        exit(1)
    }
    // Split string into lines, ensuring reading empty line
    // also creating list.
    var strList: [String] = []
    let inputLines = inputString.components(separatedBy: .newlines)

    // Convert from string of list to array of strings.
    for str in inputLines {
        if !str.isEmpty {
            strList.append(str)
        }
        
        if inputLines.isEmpty {
            let data = Data("No strings found.".utf8)
            output.write(data)
            continue
        }
    }

    // Convert from list to array
    let arrayStr = strList

    // Call function.
    for strEle in arrayStr {
        let maxLength = maxRun(strRun:strEle)
        // Display results to user.
        print("The max run of \(strEle) is \(maxLength).")

        // Display to output file.
        let outputString = "The max run of \(strEle) is \(maxLength).\n"
        if let data = outputString.data(using: .utf8) {
            output.write(data)
        }
    }

    // Close input & output file.
    input.closeFile()
    output.closeFile()
}
