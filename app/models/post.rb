class Post < ApplicationRecord
    validates :title, {presence: true}
    validates :content, {presence: true, length:{maximum: 140}}
end
