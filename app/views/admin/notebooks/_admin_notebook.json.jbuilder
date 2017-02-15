json.extract! admin_notebook, :id, :category_id, :description, :created_at, :updated_at
json.url admin_notebook_url(admin_notebook, format: :json)