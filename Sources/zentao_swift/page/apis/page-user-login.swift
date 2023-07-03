//
//  File.swift
//  
//
//  Created by 刘斌斌 on 2022/11/7.
//

import Foundation

extension ZentaoPageApi{
    public mutating func userLogin(account:String,password:String) async {
        if(isLogined){
            return
        }
        let verifyRand = await getLoginVerifyRand()
        logger.info("userLogin verifyRand:\(verifyRand)")
        let r = await request.post(path: url.absoluteString + "/user-login.html", body:     [
            "account":account,
            "password": (password.md5()+verifyRand).md5(),
            "passwordStrength":"0",
            "verifyRand":verifyRand,
            "keepLogin":"1",
        ])
        logger.info("userLogin result:\(r)")
        isLogined = true
    }
    private func getLoginVerifyRand() async -> String {
        let s = await request.get(path: url.absoluteString + "/user-login.html")
        let pattern = #"id='verifyRand' value='(\d+)'"#;
        let m = matches(for: pattern, in: s)
        let verifyRand = m[0]
        return verifyRand
    }
    private func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            return results.map { match in
                let rangeBounds = match.range(at: 1)
                guard let range = Range(rangeBounds, in: text) else {
                    return ""
                }
                return String(text[range])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
import CryptoKit

extension String {
    func md5() -> String {
        return Insecure.MD5.hash(data: self.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
    }
}
//function computePasswordStrength(password) {
//    if (password.length == 0)
//        return 0;
//    var strength = 0;
//    var length = password.length;
//    var complexity = new Array();
//    for (i = 0; i < length; i++) {
//        letter = password.charAt(i);
//        var asc = letter.charCodeAt();
//        if (asc >= 48 && asc <= 57) {
//            complexity[0] = 1
//        } else if ((asc >= 65 && asc <= 90)) {
//            complexity[1] = 2
//        } else if (asc >= 97 && asc <= 122) {
//            complexity[2] = 4
//        } else {
//            complexity[3] = 8
//        }
//    }
//    var sumComplexity = 0;
//    for (i in complexity)
//        sumComplexity += complexity[i];
//    if ((sumComplexity == 7 || sumComplexity == 15) && password.length >= 6)
//        strength = 1;
//    if (sumComplexity == 15 && password.length >= 10)
//        strength = 2;
//    return strength
//}
