json.extract! list, :id, :name, :created_at, :updated_at
json.expenses!(list.expenses) do |expense|
  json.id expense.id
  json.name expense.name
  json.amount expense.amount
  json.created_at expense.created_at
  json.updated_at expense.updated_at
end
json.url list_url(list, format: :json)
