# frozen_string_literal: true

require_relative '../lib/processor'

RSpec.describe Processor do
  describe '#process' do
    let(:output) { 'spec/output' }

    after { FileUtils.rm_rf(output) }

    it 'proceses a directory of wav files and writes metadata to XML files' do
      allow(Time).to receive(:now).and_return(Time.at(0))

      input_dir = 'spec/fixtures'
      output_dir = "#{output}/#{Time.now.to_i}"

      described_class.process(input_dir, output)

      Dir.each_child(output_dir) do |filename|
        xml_content = File.read(File.join(output_dir, filename))
        expect(xml_content).to include('<format>PCM</format>')
      end
    end
  end
end
