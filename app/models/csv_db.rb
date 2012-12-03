require 'csv'
require 'pp'

	class CsvDb

		class << self
			def convert_save(model_name, csv_data)
				csv_file = csv_data.read
				CSV.parse(csv_file) do |row|
					#generate real model class based on model_name
					target_model = model_name.classify.constantize
					new_object = target_model.new
					column_iterator = -1
					# column_names return model's columns
					target_model.column_names.each do |key|
						column_iterator += 1
						unless key == "id"
							value = row[column_iterator]
							new_object.send "#{key}=", value
						end
					end
					#pp new_object
					new_object.send :create
					
				end
			end
		end

	end

