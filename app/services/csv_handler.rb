require 'csv'
class CsvHandler
  # CSV_HEADER = ["nom", "adresse", "téléphone", "url google maps", "site web"]
  #
  # def write_csv(data, filename)
  #   CSV.open("./data/#{filename}", 'wb') do |csv|
  #     # CSV.generate(col_sep: ';') do |csv|
  #     csv << CSV_HEADER
  #     data.each do |line|
  #       csv << line
  #     end
  #     csv
  #   end
  # end

  def read(csv_file_path)
    file = File.open(csv_file_path)
    extract_rows(file)
  end

  private

  def check_separator(file)
    header = File.open(file.path){ |f| f.readline }
    if header.include?(",")
      ","
    elsif header.include?("|")
      "|"
    elsif header.include?(";")
      ";"
    else
      "\t"
    end
  end

  def extract_rows(file)
    csv_rows = []
    separator = check_separator(file)

    CSV.foreach(file.path, headers: true, encoding: 'bom|utf-8', col_sep: separator) do |row|
      csv_rows << row
    end
    return csv_rows

  rescue ArgumentError
    # The file is not in UTF-8: convert it before parsing
    file_utf8 = convert_to_utf(file)

    CSV.parse(file_utf8, headers: true, encoding: 'bom|utf-8', col_sep: separator) do |row|
      csv_rows << row
    end
    return csv_rows
  end
end
