module Twiller
  class Config
    FILENAME = 'config.yaml'

    def self.instance
      @@config ||= YAML.load(File.open(FILENAME))
    end

    def self.method_missing(method, *args, &block)
      if self.instance.respond_to? method
        self.instance.send(method, *args, &block) if @@config.respond_to? method
      else
        super(method, *args, &block)
      end
    end

    def self.save
      File.open(FILENAME, 'w') do |out|
        YAML.dump(@@config, out)
      end
    end
  end
end
