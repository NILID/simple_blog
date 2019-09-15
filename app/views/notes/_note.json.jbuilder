json.extract! note, :id, :title, :desc, :preview, :created_at, :updated_at
json.url note_url(note, format: :json)
