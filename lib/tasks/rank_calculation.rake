namespace :ranks do
  desc 'Ranks calculation'
  task :calc_ranks => :environment do
    RankCalculatorJob.perform_later
  end
end