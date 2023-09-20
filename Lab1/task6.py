print("Python-калькулятор Нечайко Поліни! Можливі оператори: +, -, *, /")
while True:
    try:
        a = float(input("Введіть перше число: "))
        b = float(input("Введіть друге число: "))
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
            if b == 0:
                print("На нуль ділити не можна! Спробуйте ще раз.")
                continue
            res = a / b

        print("Результат= ", res)

        ques = input("Бажаєте зробити нове обчислення? (y-так): ")
        if ques.lower() != 'y':
            break
    except ValueError:
        print("Введено не число, спробуйте ще раз!")