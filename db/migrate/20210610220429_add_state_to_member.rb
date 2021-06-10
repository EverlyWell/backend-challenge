class AddStateToMember < ActiveRecord::Migration[5.1]
  def change
    add_column :members, :state, :string, default: 'initialized'
  end
end
