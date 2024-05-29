require_relative '../lib/wav_reader'

RSpec.describe WavReader do
  context '#metadata' do
    context 'valid' do
      let(:valid) { 'spec/fixtures/valid.wav' }
      let(:valid_no_extension) { 'spec/fixtures/valid' }

      it 'extracts metadata from a valid wav file with extension' do
        metadata = described_class.metadata(valid)
        expect(metadata[:format]).to eq('PCM')
        expect(metadata[:channel_count]).to eq(2)
        expect(metadata[:sampling_rate]).to eq(44100)
        expect(metadata[:bit_depth]).to eq(16)
        expect(metadata[:byte_rate]).to eq(176400)
        expect(metadata[:bit_rate]).to eq(1411200)
      end

      it 'extracts metadata from a valid wav file without extension' do
        metadata = described_class.metadata(valid_no_extension)
        expect(metadata[:format]).to eq('PCM')
        expect(metadata[:channel_count]).to eq(2)
        expect(metadata[:sampling_rate]).to eq(44100)
        expect(metadata[:bit_depth]).to eq(16)
        expect(metadata[:byte_rate]).to eq(176400)
        expect(metadata[:bit_rate]).to eq(1411200)
      end
    end

    context 'invalid' do
      let(:corrupted) { 'spec/fixtures/corrupted.wav' }
      let(:invalid_png) { 'spec/fixtures/invalid.png' }
      let(:invalid_txt) { 'spec/fixtures/invalid.txt' }
      let(:empty) { 'spec/fixtures/empty.wav' }

      it 'returns nil for a corrupted wav file' do
        metadata = described_class.metadata(corrupted)
        expect(metadata).to eq(nil)
      end

      it 'returns nil for an invalid png file' do
        metadata = described_class.metadata(invalid_png)
        expect(metadata).to eq(nil)
      end

      it 'returns nil for an invalid txt file' do
        metadata = described_class.metadata(invalid_txt)
        expect(metadata).to eq(nil)
      end

      it 'returns nil for an empty wav file' do
        metadata = described_class.metadata(invalid_txt)
        expect(metadata).to eq(nil)
      end
    end
  end
end
