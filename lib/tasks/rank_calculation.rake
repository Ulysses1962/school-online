namespace :ranks do
  desc 'Ranks calculation'
  task calc_ranks :environment do
    RankCalculator.perform_later
  end
end