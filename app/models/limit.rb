class Limit < ActiveHash::Base
  self.data = [
    { id: 1, name: 'select' },
    { id: 2, name: '1週間' },
    { id: 3, name: '2週間' },
    { id: 4, name: '3週間' },
  ]

  include ActiveHash::Associations
  has_many :reviews

end
