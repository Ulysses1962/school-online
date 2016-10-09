namespace :rank_calculation do
  desc 'Ranks calculation'
  task :calculate_ranks => :environment do
    RankCalculatorJob.perform_later
  end
end