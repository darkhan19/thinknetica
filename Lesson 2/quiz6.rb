basket = {}
ttl = []
ttll = []
loop do 
        list = {}
        puts "Введите название товара"
        name = gets.chomp.to_s
        break if name == "стоп"
        puts "Введите стоимость товара"
        price = gets.chomp.to_f
        list[:price] = price.to_f
        puts "Введите количетсво"
        count = gets.chomp.to_f
        list[:count] = count
        basket[name] = list
        ttll = count * price 
        ttl.push ttll # не знал как сделать так чтоб сохранял данные, он запоминал только последние данные
    end

puts "Ваш товар #{basket}"
puts "Общая сумма: #{ttl.sum}"
