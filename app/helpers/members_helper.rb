module MembersHelper
  def friendly_path_to_member(path)
    path.map(&:name).join(' -> ')
  end
end
