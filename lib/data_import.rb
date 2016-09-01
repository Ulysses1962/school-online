require 'roo'
module DataImport
  #-----------------------------------------------------------------------
  # Импорт данных о школе и пользователях из таблицы Excel
  # Применяется для начального ввода данных в систему 
  #-----------------------------------------------------------------------
  def self.school_import(data_file)
    xlsx = Roo::Spreadsheet.open(data_file)
    s = xlsx.sheet('school')
    
    code         = s.b1
    full_name    = s.b2
    address      = s.b3       
    email        = s.b4       
    phone_number = s.b5       

    School.create!(school_code: code, school_name: full_name, school_address_string: address, 
      school_email: email, school_phone: phone_number) unless School.exists?(school_code: code)

    xlsx.close
  end

  def self.subjects_import(data_file)
    xlsx = Roo::Spreadsheet.open(data_file)

    xlsx.sheet('subjects').each_row_streaming do |row|
      subject = row.reject(&:empty?)
      name = subject.delete_at(0)
      subject.each {|level| Subject.create!(name: name, level: level.value)}
    end

    xlsx.close
  end

  def self.import_teachers(data_file)
    xlsx = Roo::Spreadsheet.open(data_file)
    s = xlsx.sheet('teachers')
  
    xlsx.close
  end

  def self.import_students(data_file)
    xlsx = Roo::Spreadsheet.open(data_file)
    s = xlsx.sheet('teachers')

  
    xlsx.close
  end

  def self.import_tariffication(data_file)
    xlsx = Roo::Spreadsheet.open(data_file)
    s = xlsx.sheet('tariffication')

    xlsx.close
  end
 
end