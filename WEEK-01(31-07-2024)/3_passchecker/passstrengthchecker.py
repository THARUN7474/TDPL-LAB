from mostusedpasswords import passwords


class PasswordChecker:
    def __init__(self, password):
        self.password = password

    def is_strong_password(self):
        if len(self.password) < 8:
            return False
        if not any(char.isdigit() for char in self.password):
            return False
        if not any(char.islower() for char in self.password):
            return False
        if not any(char.isupper() for char in self.password):
            return False
        if not any(char in '!@#$%^&*()_+' for char in self.password):
            return False
        return True

    def password_strength_checker(self):
        score = 0

        # Rule 1: Length
        if len(self.password) >= 12:
            score += 3
        elif len(self.password) >= 8:
            score += 2
        else:
            score += 1

        # Rule 2: Character types
        if any(char.isdigit() for char in self.password):
            score += 1
        if any(char.islower() for char in self.password):
            score += 1
        if any(char.isupper() for char in self.password):
            score += 1
        if any(char in '!@#$%^&*()_+' for char in self.password):
            score += 1

        # Rule 3: (simplified check, in reality you need a list of personal details) checked with most common passwords

        if not any(detail.lower() in self.password.lower() for detail in passwords):
            score += 2
        else:
            print(f"Your password is also in top 200 most used passwords list")

        # Rule 4: Avoid maxm sequential characters and all same letters cases
        sequential = 0
        for i in range(len(self.password) - 1):
            if ord(self.password[i+1]) == ord(self.password[i]) + 1:
                sequential += 1

        same = 0
        for i in range(len(self.password) - 1):
            if ord(self.password[i+1]) == ord(self.password[i]):
                same += 1

        if (same != (len(self.password) - 1)) & (sequential != len(self.password)//2):
            score += 1

        # Rule 5: Uniqueness and Memorability (Simplified to just checking uniqueness)----using conceps of unique letters
        if len(set(self.password)) > len(self.password) // 2:
            score += 1

        # Determine password strength
        if score <= 5:
            strength = "Weak Password"
        elif score <= 8:
            strength = "Good Password"
        else:
            strength = "Strong Password"

        return score, strength
