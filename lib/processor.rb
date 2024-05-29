require_relative 'wav_reader'
require_relative 'xml_writer'

class Processor
  def self.process(input_dir, output_dir = 'output')
    timestamp = Time.now.to_i
    output_dir_ts = "#{output_dir}/#{timestamp}"
    FileUtils.mkdir_p(output_dir_ts)

    Dir.each_child(input_dir) do |filename|
      input_path = File.join(input_dir, filename)
      next unless File.file?(input_path)

      metadata = WavReader.metadata(input_path)
      next unless metadata

      basename = File.basename(input_path, '.*')
      output_path = File.join(output_dir_ts, "#{basename}.xml")

      XmlWriter.write(metadata, output_path)
    rescue StandardError => e
      puts "Error processing #{filename}: #{e.message}"
      next
    end
  end
end
