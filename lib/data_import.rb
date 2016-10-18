require 'roo'
require 'securerandom'

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
    school_id = current_user.school_id

    xlsx.sheet('subjects').each_row_streaming do |row|
      subject = row.reject(&:empty?)
      name = subject.delete_at(0)
      Subject.create!(school_id: school_id, name: name)
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
    school_code = xlsx.sheet('school').b1
    school_id = current_user.school_id

    current_student = 1
    xlsx.sheet('students').each_row_streaming do |row|
      student           = row.reject(&:empty?)
      username          = "User" << "_#{school_code}_#{current_student}"
      password          = User.get_password
      first_name        = student[0].value
      last_name         = student[1].value
      address           = student[2].value
      phones            = student[3].value.split(', ')
      pers_file         = student[4].value
      birth_date        = student[5].value
      a_class           = student[6].value
      a_class_parallel  = student[7].value

      student_record = Student.new do |s|
        # General user information  
        s.username = username
        s.password = password
        s.password_confirmation = password
        s.school_id = school_id
        s.academic_class = a_class
        s.academic_parallel = a_class_parallel 
        s.roles << Role.find_by(rolename: 'student')
        # Building profile
        s.build_profile
        # Profile field initialization     
        s.profile.first_name = first_name
        s.profile.last_name = last_name
        s.profile.birth_date = birth_date
        s.profile.address_string = address
        s.profile.personal_file_code = pers_file
        phones.each { |num| s.profile.phones << num }
      end  
      student_record.save
      current_student += 1
    end
    # Parent initialization...
    xlsx.sheet('parents').each_row_streaming do |row|
      parent          = row.reject(&:empty?)
      first_name      = parent[0].value
      last_name       = parent[1].value
      full_name       = unless first_name == 'не вказано' then [first_name, last_name].join(' ') else last_name end

      p_code_offset = 4
      personal_codes  = []
      while p_code_offset < parent.lenght
        personal_codes << parent[p_code_offset].value
        p_code_offset += 1
      end  

      personal_codes.each do |code|
        student = Student.joins(:profile).where('personal_file_code' == code)
        student.profile.parent_name = full_name
        student.save 
      end  
    end   
    
    xlsx.close
  end

  def self.import_tariffication(data_file)
    xlsx = Roo::Spreadsheet.open(data_file)
    s = xlsx.sheet('tariffication')

    xlsx.close
  end
end