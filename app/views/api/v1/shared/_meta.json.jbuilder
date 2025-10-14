# frozen_string_literal: true

json.meta do
  json.count pagy.count
  json.page pagy.page
  json.limit pagy.limit
  json.last pagy.last
end
