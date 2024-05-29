require 'rexml/document'
require 'rexml/formatters/pretty'

class XmlWriter
  def self.write(data, output_path)
    doc = REXML::Document.new
    doc << REXML::XMLDecl.new('1.0', 'UTF-8')

    track = doc.add_element('track')
    data.each do |key, value|
      track.add_element(key.to_s).text = value.to_s
    end

    formatter = REXML::Formatters::Pretty.new(2)
    formatter.compact = true

    File.open(output_path, 'w') do |f|
      formatter.write(doc, f)
    end
  end
end
