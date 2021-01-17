# frozen_string_literal: true

module Members
  module Website
    module HeadingExtractionActions
      class ExtractHeadings
        extend LightService::Action

        expects :html_doc
        promises :headings

        executed do |ctx|
          doc = Nokogiri::HTML(ctx.html_doc)

          headers = doc.xpath('/html/body//*[self::h1 or self::h2 or self::h3]')

          ctx.headings = []

          headers&.each do |header|
            if (heading = header&.text&.squish).present?
              ctx.headings << heading
            end
          end
        end
      end
    end
  end
end
