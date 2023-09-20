import math
memoryres = []
print("Python-калькулятор Нечайко Поліни. \nМожливі оператори: +, -, *, /, ^, √, % \nПримітка: квадратний корінь береться від першого введеного числа.")
while True:
    try:
        a = float(input("Введіть перше число: "))
        b = float(input("Введіть друге число: "))
        oper = input("Введіть оператор: ")

        if oper not in ('+', '-', '*', '/', '%', '^', '√', 'M','R'):
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

        expression = f"{a} {oper} {b}"
        memoryres.append((expression, res))

        print("Результат=", res)

        ques2 = input("Бажаєте відкрити журнал обчислень? (y-так, інший символ - відмова): ")
        if ques2.lower() == 'y':
            if memoryres:
                print("Журнал обчислень:")
                for i, (expression, result) in enumerate(memoryres, start=1):
                    print(f"{i}. {expression} = {result}")
            else:
                print("Журнал порожній!")

        ques1 = input("Бажаєте зробити нове обчислення? (y-так): ")
        if ques1.lower() != 'y':
            break
    except ValueError:
        print("Введено не число, спробуйте ще раз!")