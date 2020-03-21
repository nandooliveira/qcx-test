Rails.application.routes.draw do
  mount Api::V1::Root => '/'
end
