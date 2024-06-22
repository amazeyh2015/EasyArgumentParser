import XCTest
@testable import EasyArgumentParser

final class EasyArgumentParserTests: XCTestCase {
    // XCTest Documentation
    // https://developer.apple.com/documentation/xctest

    // Defining Test Cases and Test Methods
    // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    
    func testParser() throws {
        let parser = ArgumentParser()
        
        let words1 = ["analyze", "core", "--file", "xxx/xxx.xml", "--dsym", "xxx/xxx.app.dSYM"]
        let result1 = parser.parse(words1)
        XCTAssertTrue(result1.commands == ["analyze", "core"])
        XCTAssertTrue(result1.arguments.count == 2)
        XCTAssertTrue(result1.arguments["file"] == "xxx/xxx.xml")
        XCTAssertTrue(result1.arguments["dsym"] == "xxx/xxx.app.dSYM")
        
        let words2 = ["cmd", "--file", "xxx/xxx.xml", "--nosym"]
        let result2 = parser.parse(words2)
        XCTAssertTrue(result2.commands == ["cmd"])
        XCTAssertTrue(result2.arguments.count == 2)
        XCTAssertTrue(result2.arguments["file"] == "xxx/xxx.xml")
        XCTAssertTrue(result2.arguments["nosym"] == "")
        
        let words3 = ["cmd", "-f", "xxx/xxx.xml", "--nosym"]
        let result3 = parser.parse(words3)
        XCTAssertTrue(result3.commands == ["cmd"])
        XCTAssertTrue(result3.arguments.count == 2)
        XCTAssertTrue(result3.arguments["f"] == "xxx/xxx.xml")
        XCTAssertTrue(result3.arguments["nosym"] == "")
        
        let words4 = ["cmd", "-f", "xxx/xxx.xml", "abc", "--nosym"]
        let result4 = parser.parse(words4)
        XCTAssertTrue(result4.commands == ["cmd"])
        XCTAssertTrue(result4.arguments.count == 1)
        XCTAssertTrue(result4.arguments["f"] == "xxx/xxx.xml")
        
        let words5 = ["cmd", "--", "xxx/xxx.xml", "--", "abc"]
        let result5 = parser.parse(words5)
        XCTAssertTrue(result5.commands == ["cmd"])
        XCTAssertTrue(result5.arguments.count == 1)
        XCTAssertTrue(result5.arguments[""] == "abc")
        
        let words6 = ["cmd", "-f", "xxx/xxx.xml", "--end-symbol", "-[TestClass testMethod]"]
        let result6 = parser.parse(words6)
        XCTAssertTrue(result6.commands == ["cmd"])
        XCTAssertTrue(result6.arguments.count == 2)
        XCTAssertTrue(result6.arguments["f"] == "xxx/xxx.xml")
        XCTAssertTrue(result6.arguments["end-symbol"] == "-[TestClass testMethod]")
    }
}
