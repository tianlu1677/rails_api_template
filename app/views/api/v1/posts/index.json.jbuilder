# frozen_string_literal: true

json.posts @posts do |post|
  json.partial! 'api/v1/posts/post', post: post
end
json.partial! 'api/v1/shared/meta', pagy: @pagy
