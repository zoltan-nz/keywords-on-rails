require 'csv'

i = 0
filename = 1
csvfile = CSV.open("../database/#{filename}.csv", "wb")
CSV.foreach("../database/keywords.csv") do |row|
  if i.modulo(10000) == 0
    csvfile.close
    filename += 1
    csvfile = CSV.open("../database/#{filename}.csv", "wb")
  end

  csvfile << row
  i += 1

end

csvfile.close
