class CreateIssueStates < ActiveRecord::Migration
  def change
    create_table :issue_states do |t|
      t.string :name
      t.integer :next_state_id

      t.timestamps
    end
  end
end
