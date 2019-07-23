ActiveAdmin.register IssueState do

  index do
    column :id
    column :name
    column :next_state
  end
  form do |f|

    f.inputs do
      f.input :name
      f.input :next_state
    end

    f.actions
  end
end
