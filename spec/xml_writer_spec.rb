# frozen_string_literal: true

require_relative '../lib/xml_writer'

RSpec.describe XmlWriter do
  context '#write' do
    let(:output_path) { 'spec/fixtures/output.xml' }

    after { File.delete(output_path) }

    it 'writes metadata to an XML file' do
      metadata = {
        format: 'PCM',
        channel_count: 2,
        sampling_rate: 44100,
        bit_depth: 16,
        byte_rate: 176400,
        bit_rate: 1411200,
        custom: 'value'
      }

      described_class.write(metadata, output_path)

      content = File.read(output_path)
      expect(content).to include('<format>PCM</format>')
      expect(content).to include('<channel_count>2</channel_count>')
      expect(content).to include('<sampling_rate>44100</sampling_rate>')
      expect(content).to include('<bit_depth>16</bit_depth>')
      expect(content).to include('<byte_rate>176400</byte_rate>')
      expect(content).to include('<bit_rate>1411200</bit_rate>')
      expect(content).to include('<custom>value</custom>')
    end
  end
end
