require 'open-uri'

class HeadingScraper
  include Executable

  def initialize(member)
    @member = member
  end

  def execute
    html_doc = Nokogiri::HTML(URI.open(member.url))

    headings = heading_nodes(html_doc).map { |node| node.text }.uniq

    headings.each { |heading_text| create_heading(heading_text) }
  end

  private

  attr_reader :member

  def heading_nodes(parsed_doc)
    parsed_doc.search('h1, h2, h3')
  end

  def create_heading(content)
    Heading.create(member: member, content: content)
  end
end