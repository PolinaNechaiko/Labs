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

        print("Результат=", res)
        ques3 = input("Бажаєте зберегти результат у архів? (y-так, інший символ - відмова): ")
        if ques3.lower() == 'y':
            memoryres.append(res)
            print("Результат збережено в архів.")

        ques2 = input("Бажаєте відновити архів? (y-так, інший символ - відмова): ")
        if ques2.lower() == 'y':
            if memoryres:
                print("Архів збережених результатів:")
                for result in memoryres:
                    print(result)
            else:
                print("Архів порожній!")

        ques1 = input("Бажаєте зробити нове обчислення? (y-так): ")
        if ques1.lower() != 'y':
            break
    except ValueError:
        print("Введено не число, спробуйте ще раз!")