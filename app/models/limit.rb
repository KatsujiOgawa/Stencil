class Limit < ActiveHash::Base
  self.data = [
    { id: 1, name: 'select' },
    { id: 3, name: '3日間' },
    { id: 7, name: '７日間' },
    { id: 10, name: '10日間' },
  ]

  include ActiveHash::Associations
  has_many :reviews

end
