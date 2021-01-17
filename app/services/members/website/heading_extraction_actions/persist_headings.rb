# frozen_string_literal: true

module Members
  module Website
    module HeadingExtractionActions
      class PersistHeadings
        extend LightService::Action

        expects :member, :headings

        executed do |ctx|
          heading_attrs = ctx.headings.map { |heading| { text: heading } }

          if heading_attrs.present?
            member_headings = ctx.member.headings.build(heading_attrs)
            member_headings.each { |member_heading| member_heading.save }
          end
        end
      end
    end
  end
end
