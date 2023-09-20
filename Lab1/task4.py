print("Python-калькулятор Нечайко Поліни! Можливі оператори: +, -, *, /")
while True:
    try:
        a = int(input("Введіть перше число: "))
        b = int(input("Введіть друге число: "))
        oper = input("Введіть оператор: ")

        if oper not in ('+', '-', '*', '/'):
            print("Помилка! Введіть дійсний оператор: ")
            continue

        if oper == '+':
            res = a + b
        elif oper == '-':
            res = a - b
        elif oper == '*':
            res = a * b
        elif oper == '/':
            res = a / b

        print("Результат= ", res)

        ques = input("Бажаєте зробити ще обчислення? (y-так): ")
        if ques.lower() != 'y':
            break
    except ValueError:
        print("Помилка! Спробуйте ще раз.")