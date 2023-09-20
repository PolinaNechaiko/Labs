import math
print("Python-калькулятор Нечайко Поліни. Можливі оператори: +, -, *, /, ^, √, %. Примітка: квадратний корінь береться від першого введеного числа.")
while True:
    try:
        a = float(input("Введіть перше число: "))
        b = float(input("Введіть друге число: "))
        oper = input("Введіть оператор: ")

        if oper not in ('+', '-', '*', '/', '%', '^','√'):
            print("Помилка! Введіть дійсний оператор: ")
            continue

        if oper == '+':
            res = a + b
        elif oper == '-':
            res = a - b
        elif oper == '*':
            res = a * b
        elif oper == '%':
            res = a % b
        elif oper == '^':
            res = a ** b
        elif oper == '/':
            if b == 0:
                print("Операція неможлива! Спробуйте ще раз.")
                continue
            res = a / b
        elif oper == '√':
            if a < 0:
                print("Операція неможлива! Спробуйте ще раз. ")
                continue
            res = math.sqrt(a)

        print("Результат=", res)

        ques = input("Бажаєте зробити нове обчислення? (y-так): ")
        if ques.lower() != 'y':
            break
    except ValueError:
        print("Введено не число, спробуйте ще раз!")