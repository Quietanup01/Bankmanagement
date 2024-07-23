package com.uniquedeveloper.registration;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordVerifier {

    public static void main(String[] args) {
        String hashedPasswordFromDB = "$2a$10$0RxHMeDB3gjp7QnDm1h7ZO/yyk.PpxEnHinp1XEiWnsU65cvfAwkq";
        String plaintextPasswordToCheck = "12345"; // Replace with the password you want to check

        // Check if the plaintext password matches the hashed password
        boolean passwordMatches = BCrypt.checkpw(plaintextPasswordToCheck, hashedPasswordFromDB);

        if (passwordMatches) {
            System.out.println("Password matches!");
        } else {
            System.out.println("Password does not match!");
        }
    }
}

