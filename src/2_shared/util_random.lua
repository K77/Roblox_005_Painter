local module = {}
math.randomseed(tostring(os.time()):reverse():sub(1, 6))

function module.getBetween(a:number,b:number)
    local num0 = math.random()
    local num1 = a + num0 * (b-a)
    return num1
end

return module