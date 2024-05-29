# frozen_string_literal: true

require 'bindata'

class WavReader
  class Header < BinData::Record
    endian :little

    string :chunk_id, read_length: 4
    uint32 :chunk_size
    string :format, read_length: 4

    string :subchunk1_id, read_length: 4
    uint32 :subchunk1_size
    uint16 :audio_format
    uint16 :num_channels
    uint32 :sample_rate
    uint32 :byte_rate
    uint16 :block_align
    uint16 :bits_per_sample

    def valid?
      chunk_id == 'RIFF' && format == 'WAVE' && subchunk1_id == 'fmt '
    end
  end

  def self.metadata(input_path)
    file = File.read(input_path)
    header = Header.read(file)
    return unless header.valid?

    {
      format: header.audio_format == 1 ? 'PCM' : 'Compressed',
      channel_count: header.num_channels,
      sampling_rate: header.sample_rate,
      bit_depth: header.bits_per_sample,
      byte_rate: header.byte_rate,
      bit_rate: header.sample_rate * header.num_channels * header.bits_per_sample
    }
  rescue EOFError, IOError
    nil
  end
end
