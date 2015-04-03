json.array!(@patients) do |patient|
  json.extract! patient, :id, :firstname, :lastname, :cnumber
  json.url patient_url(patient, format: :json)
end
