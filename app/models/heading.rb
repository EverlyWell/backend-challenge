class Heading < ApplicationRecord
  belongs_to :member

  after_create :update_search_vector

  private

  def update_search_vector
    # Use a prepared statement to prevent a SQL Injection
    query = <<-SQL
      UPDATE headings SET search_vector = to_tsvector('english', $1) WHERE id = $2
    SQL

    ApplicationRecord.connection.exec_query(
      query,
      '-- UPDATE MEMBER SEARCH --',
      [[nil, text], [nil, id]],
      prepare: true
    )
  end
end
