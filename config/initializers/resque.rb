# Resque.logger = MonoLogger.new(File.open("#{Rails.root}/log/resque.log", "w+"))
# Resque.logger.formatter = Resque::VerboseFormatter.new
Resque.redis = ENV['REDISTOGO_URL']
