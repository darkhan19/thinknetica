def days
    year = {
        jan: 31,
        feb: 29,
        mar: 31,
        apr: 30,
        may: 31,
        jun: 30,
        jul: 31,
        aug: 31,
        sep: 30,
        oct: 31,
        nov: 30,
        dec: 31
    }
    months = year.select { |m,d| d == 30 }
    puts months
end
