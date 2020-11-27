class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: 'select'},
    { id: 2, name: 'プログラミング' },
    { id: 3, name: 'IT/ネットワーク' },
    { id: 4, name: '経済/ビジネス' },
    { id: 5, name: '心理学/メンタルケア' },
    { id: 6, name: 'コミュニケーション/プレゼン' },
    { id: 7, name: '思想/哲学' },
    { id: 8, name: 'デザイン/アート' },
    { id: 9, name: '医学/健康' },
    { id: 10, name: '自己啓発' },
    { id: 11, name: '社会/政治' },
    { id: 12, name: '資格/就職' },
    { id: 13, name: '教育' },
    { id: 14, name: '語学/辞典' }
  ]

  include ActiveHash::Associations
  has_many :reviews

end
