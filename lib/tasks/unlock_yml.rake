namespace :db do
  namespace :seed do
    desc 'Rename db/seeds/*.yml.sample to db/seeds/*.yml'
    task unlock_yml: :environment do
      samples = Rails.root.join('db', 'seeds', '*.yml.sample')
      Dir.glob(samples).each do |sample|
        file_name = File.basename(sample, File.extname(sample))
        FileUtils.mv(sample, Rails.root.join('db', 'seeds', file_name), verbose: true)
      end
    end
  end
end
