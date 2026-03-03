while True:
    try:
        height = int(input("Height: "))
        if height >= 1 and height <= 8:
            break
    except ValueError:
        pass

for row in range(1, height + 1):
    for space in range(height - row):
        print(" ",end='')

    for left in range(1, row + 1):
        print("#",end='')

    print("  ",end='')

    for right in range(1, row + 1):
        print("#",end='')
    print()

