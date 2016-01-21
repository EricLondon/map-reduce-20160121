class MapReducer
  def initialize(options = {})
    options ||= {}
    fail 'Action required' if options[:action].nil?
    @action = options[:action]
  end

  def execute
    send(@action)
  end

  private

  def map
    ARGF.each do |line|
      line = line.chomp
      next if line.nil? || line.empty?

      line
        .downcase
        .gsub(/[^0-9a-z]/i, '')
        .split('')
        .inject(Hash.new(0)) { |h, e| h[e] += 1; h }
        .each { |char, count| puts "#{char}\t#{count}" }
    end
  end

  def reduce
    key = value = prev_key = nil
    key_total = 0

    ARGF.each do |line|
      line = line.chomp
      next if line.nil? || line.empty?
      (key, value) = line.split(/\t/)

      if prev_key && key != prev_key && key_total > 0
        puts "#{prev_key}\t#{key_total}"
        prev_key = key
        key_total = 0
      elsif !prev_key
        prev_key = key
      end

      key_total += value.to_i
    end

    puts "#{key}\t#{key_total}"
  end
end
