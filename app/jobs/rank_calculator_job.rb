class RankList
  attr_accessor rank_type
  attr_accessor rank_hash
  attr_accessor subj_code
  attr_accessor rank_list

  def initialize(type, subject)
    @rank_hash = {}
    @rank_list = []
    @subj_code = nil
  end  

  def sort
    @rank_list = @rank_hash.sort_by(&:last).reverse unless rank_hash.empty?
  end  
end 

class RankCalculatorJob < ApplicationJob
  queue_as :default
  
  def perform
     School.select('id').each do |school|
       update_class_ranks school.id
       update_parallel_ranks school.id  
       build_school_ranks school.id    
     end

     build_city_ranks  
  end
  #---------------------------------------------------------------------------------------------------
  # Ranks updating routines 
  #---------------------------------------------------------------------------------------------------
  def update_class_ranks(school_id)
    classes = Student.joins(:profile).select('academic_class, academic_parallel').distinct.
      where('school_id = ?', school_id).order(academic_class: :asc)

    classes.each do |a|
      build_class_ranks_by_subject school_id, a
      build_class_ranks school_id, a
    end
  end    

  def update_parallel_ranks(school_id)
    parallels = Student.joins(:profile).select('academic_class').distinct.where('school_id = ?', school_id).order(academic_class: :asc)

    parallels.each do |p|
      build_parallel_ranks_by_subject school_id, p
      build_parallel_ranks school_id, p
    end   
  end  

  #---------------------------------------------------------------------------------------------------
  # Ranks building routines 
  #---------------------------------------------------------------------------------------------------
  def build_city_ranks
    students = Student.all.select('id')

    ranks = calc_ranks students
    ranks.rank_type = Rank::CITY_LEVEL_RANK

    save_ranks ranks unless ranks.rank_list.empty?
  end 

  def build_school_ranks(school)
    students = Student.where('school_id = ?', school).select('id')

    ranks = calc_ranks students
    ranks.rank_type = Rank::SCHOOL_LEVEL_RANK

    save_ranks ranks unless ranks.rank_list.empty?
  end 

  def build_parallel_ranks_by_subject(school, parallel)
    subjects = Subject.in_school(school).select('id')
    students = Student.in_parallel(parallel.academic_class, school).select('id')

    subjects.each do |subj|
      ranks = calc_ranks students, subj
      ranks.rank_type = Rank::PARALLEL_LEVEL_SUBJ_RANK

      save_ranks ranks unless ranks.rank_list.empty?  
    end   
  end

  def build_parallel_ranks(school, parallel)
    students = Student.in_parallel(parallel.academic_class, school).select('id')

    ranks = calc_ranks students
    ranks.rank_type = Rank::PARALLEL_LEVEL_RANK

    save_ranks ranks unless ranks.rank_list.empty?
  end  

  def build_class_ranks_by_subject(school, student_class)
    subjects = Subject.in_school(school).select('id')  
    students = Student.in_class(student_class.academic_class, student_class.academic_parallel, school).select('id')

    subjects.each do |subj|
      ranks = calc_ranks students, subj
      ranks.rank_type = Rank::CLASS_LEVEL_SUBJ_RANK

      save_ranks ranks unless ranks.rank_list.empty? 
    end  
  end

  def build_class_ranks(school, student_class)
    students = Student.in_class(student_class.academic_class, student_class.academic_parallel, school).select('id')

    ranks = calc_ranks students
    ranks.rank_type = Rank::CLASS_LEVEL_RANK

    save_ranks ranks unless ranks.rank_list.empty? 
  end

  #---------------------------------------------------------------------------------------------------
  # Auxiliary routines 
  #---------------------------------------------------------------------------------------------------
  def cals_ranks(student_list, subject = nil)
    ranks = RankList.new
    ranks.subj_code = subj.id unless subject.nil?
    student_list.each do |student|
      ranks.rank_hash[student.id] = Mark.where('subject_id = ? AND student_id = ?', subj.id, student.id).this_year_marks.average('mark') unless subject.nil?
      ranks.rank_hash[student.id] = Mark.where('student_id = ?', student.id).this_year_marks.average('mark') if subject.nil?
    end 
    ranks.sort
  end  

  def save_ranks(ranks)
    ranks.rank_list.each_with_index do |r, index|
      rank = Rank.where('student_id = ? AND subject_id = ? AND rank_type = ?', r[0], ranks.subj_code, ranks.rank_type) unless ranks.subj_code.nil?
      rank = Rank.where('student_id = ? AND rank_type = ?', r[0], ranks.rank_type) if ranks.subj_code.nil?
      rank.update(rank_level: index + 1) unless rank.empty?
      Rank.create!(student_id: r[0], subject_id: ranks.subj_code, rank_type: ranks.rank_type, rank_level: index + 1) if rank.empty?
    end  
  end     


end 
