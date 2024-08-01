alphabet = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
            'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']


def caesar(start_text, shift_amount, cipher_direction):
    end_text = ""
    
    if cipher_direction == "decode":
        shift_amount *= -1

    for char in start_text:
        if char in alphabet:
            position = alphabet.index(char)
            new_position = position + shift_amount
            # end_text += alphabet[new_position]
            # ~~~~~~~~^^^^^^^^^^^^^^
            # IndexError: list index out of range
            if new_position > 25:
                end_text += alphabet[new_position % 26]
            else:
                end_text += alphabet[new_position]
        else:
            end_text += char
    print(f"Here's the {cipher_direction}d result: {end_text}")


should_end = False
while not should_end:
    direction = input(f"Type 'encode' to encrypt, type 'decode' to decrypt:\n")
    if (direction != "encode" and direction != "decode"):
        print(
            "Invalid input--[Type 'encode' to encrypt, type 'decode' to decrypt]. Please try again.")
        continue


    text = input(f"Type your message:\n").lower()
    try:
        shift = int(input(f"Type the shift number:\n"))
    except ValueError:
        print("Invalid input--[Shift must be an integer]. Please try again.")
        continue


    shift = shift % 26
    caesar(start_text=text, shift_amount=shift, cipher_direction=direction)


    restart = input(
        "Type 'yes' if you want to go again. Otherwise type 'no'.\n")
    if restart == "no":
        should_end = True
        print("Goodbye")
