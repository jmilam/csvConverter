#This application runs in order to convert the IRDS dashboard data from csv to xls
class CSVConverter
  require 'csv'
  require 'spreadsheet'
  require 'sudo'
  def initialize
	p "Initialize converter..."
    	@counter = 0
	read_write_save_file
  end

  def read_write_save_file
	p "Createing New Spreadsheet"
	book = Spreadsheet::Workbook.new
	sheet = book.create_worksheet :name => 'dashboard'
	p "Reading CSV and writing to new spreadsheet..."
 	file_path = "/media/qadprod/dashboard.csv"
	CSV.foreach(file_path, col_sep: ",", headers: true) do |row|
		if @counter == 0
			sheet.row(0).concat row.headers
		else
			column_counter = 0
			row.each do |r|
				sheet[@counter,column_counter] = r[1]
				column_counter += 1
			end
		end
		
		@counter += 1
	end
	book.write '/home/itadmin/apps/ruby/dashboard.xls'
  end

end

CSVConverter.new
