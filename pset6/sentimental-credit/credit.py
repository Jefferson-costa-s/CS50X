def main():
    number = int(input("Number: "))
    temp = number
    sum = 0
    count = 0
    digit = 0

    temp = number
    while temp > 0:
        digit = temp % 10

        if count % 2 == 1:
            doubled = digit * 2
            sum += doubled // 10 + doubled % 10
        else:
            sum += digit

        temp //= 10
        count += 1

    if sum % 10 != 0:
        print("INVALID")
        return

    temp = number
    while temp >= 100:
        temp //= 10
    first_two = temp
    first = first_two // 10

    if (first_two == 34 or first_two == 37) and count == 15:
        print("AMEX")
    elif first_two >= 51 and first_two <= 55 and count == 16:
        print("MASTERCARD")
    elif first == 4 and (count == 13 or count == 16):
        print("VISA")
    else:
        print("INVALID")


main()
