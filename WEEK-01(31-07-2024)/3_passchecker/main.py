from passstrengthchecker import PasswordChecker


def check_complexity(passw):
    checker = PasswordChecker(passw)
    if checker.is_strong_password():
        score, strength = checker.password_strength_checker()
        print(f"Password: {passw}, Score: {score}, Strength: {strength}")
    else:
        print(f"Password: {passw} is not strong enough.")
        score, strength = checker.password_strength_checker()
        print(f"you score will be this")
        print(f"Password: {passw}, Score: {score}, Strength: {strength}")


# Example usage
print('''
    some metrics used to find strength of passwords:
        # Rule 1: Length
        # Rule 2: Character types
        # Rule 3: (simplified check, in reality you need a list of personal details) checked with most common passwords
        # Rule 4: Avoid maxm sequential characters and all same letters cases
        # Rule 5: Uniqueness and Memorability (Simplified to just checking uniqueness)----using conceps of unique letters
        # Determined password strength based whole score we got from combining scores at each rule 
      \n
 ''')
passwords = ["WeakPwd", "Str0ngPwd!", "StrongPassword123!",
             "12345678", "adminPassword", "unique1!Pass"]
for pwd in passwords:
    check_complexity(pwd)
    print("-----")

print(f"--------------------------------------------------------------------------------------")
print(f"above are some random examples, you will get output as above formate!")
print(f"--------------------------------------------------------------------------------------")
user_test = input("enter the password you want to test: ")

check_complexity(user_test)
