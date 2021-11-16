class MemberResource < JSONAPI::Resource
  attributes :first_name, :last_name, :url, :short_url, :profile_metadata
  relationship :friendships, to: :many

  def short_url
    "http://goo.gl/#{@model.id.to_s}"
  end

  filter :profile_metadata

  filter :profile_metadata, apply: ->(records, value, _options) {
    records.where("profile_metadata::text ILIKE '%#{value.join}%'")
  }

end