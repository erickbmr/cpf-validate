function sum(counter, final, cpfArray)
    sum = 0
    index = 1

    #sum the numbers * counter for verification
    while counter >= final

        #Example: CPF = 555.555.555-55
        # First Time: (10 * 5) + (9 * 5) + (8 * 5) ...
        # Second Time: (11 * 5) + (10 * 5) + (9 * 5) ...
        value = counter * cpfArray[index]
        sum += value
        counter -= 1
        index += 1
    
    end

    return sum
end

function intToArray(number)

    #array to cpf, each index is a number of cpf
    cpfArray = []

    #to separate numbers by divisions
    divider = 10000000000

    #transform int to array
    #first division out of loop to set remainder value
    value = div(number, divider)
    remainder = number % divider
    append!(cpfArray, value)
    divider = div(divider, 10)

    while divider >= 1

        value = div(remainder, divider)
        append!(cpfArray, trunc(Int, value))
        remainder = remainder % divider
        divider = div(divider, 10)

    end

    return cpfArray
end

function checkDigit(cpfArray, number, remainder, count)
    
    firstDigit = number - remainder

        if firstDigit < 0
            return false
        end

        if firstDigit > 9
            if cpfArray[count] != 0
                return false
            end
        end

        if firstDigit != cpfArray[count]
            return false
        end
 
    return true

end

function validate(number)

    if isa(number, Int64)

        cpfArray = intToArray(number)

        #number to make multiplications and also index of the digit
        count = 10
        
        #first sum of validation process
        firstSum = sum(count, 2, cpfArray)

        #first verification of digit
        #round up remainder and transform to int
        remainder = trunc(Int, round(firstSum % 11))

        #expected to be the first digit
        if checkDigit(cpfArray, 11, remainder, count) == false
            return false
        end
    
        #second sum of validation process
        secondSum = sum(count + 1, 2, cpfArray)

        #second verification of digit
        remainder = trunc(Int, round(secondSum % 11))

        #expected to be the second digit
        if checkDigit(cpfArray, 11, remainder, count + 1) == false
            return false
        end
        
        #all operationd were performed and no invalidation occurred
        return true

    else
        return false
    end

end
