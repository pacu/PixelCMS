class S3Uploader
  def self.upload_directory(source, bucket, options = {})
    options = {
        :destination_dir => '',
        :threads => 5,
        :aws_access_key_id => ENV['aws_access_key_id'],
        :aws_secret_access_key => ENV['aws_secret_access_key'],
        :public => false,
        :region => 'us-east-1',
        :provider => 'AWS'

    }.merge(options)

    log = options[:logger] || Logger.new(STDOUT)

    raise 'Source must be a directory' unless File.directory?(source)

    source = source.chop if source.end_with?('/')
    if options[:destination_dir] != '' and !options[:destination_dir].end_with?('/')
      options[:destination_dir] = "#{options[:destination_dir]}/"
    end

    files = Queue.new
    Dir.glob("#{source}/**/*").select { |f| !File.directory?(f) }.each do |f|
      files << f
    end

    if options[:connection]
      connection = options[:connection]
    else
      connection = Fog::Storage::AWS::new({
                                              # :provider => options[:provider],
                                              :aws_access_key_id => options[:aws_access_key_id],
                                              :aws_secret_access_key => options[:aws_secret_access_key],
                                              :region => options[:region],
                                              :host => options[:host],
                                              :scheme => options[:scheme],
                                              :port => options[:port]

                                          })
    end

    directory = connection.directories.new(:key => bucket)


    total_files = files.size
    file_number = 0
    @mutex = Mutex.new

    threads = []
    options[:threads].times do |i|
      threads[i] = Thread.new {

        while not files.empty?
          @mutex.synchronize do
            file_number += 1
          end
          file = files.pop
          key = file.gsub(source, '')[1..-1]
          dest = "#{options[:destination_dir]}#{key}"
          log.info("[#{file_number}/#{total_files}] Uploading #{key} to #{options[:scheme]}://#{options[:host]}:#{options[:port]}/#{bucket}/#{dest}")

          directory.files.create(
              :key => dest,
              :body => File.open(file),
              :public => options[:public]
          )
        end
      }
    end
    threads.each { |t| t.join }

  end

end