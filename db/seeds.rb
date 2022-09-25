# frozen_string_literal: true

a1 = Author.create!(name: 'Mat', age: 44, email: 'aaa@bbb.ccc')
a2 = Author.create!(name: 'John', age: 30, email: 'j@o.hn')
a3 = Author.create!(name: 'Emily', age: 26, email: 'em@i.ly')

Profile.create!(author: a1, description: 'Just some content')

p1 = Post.create!(title: 'First post', author: a1)
p2 = Post.create!(title: 'Second post', author: a2)
Post.create!(title: 'Third post', author: a1)
Post.create!(title: 'Forth post', author: a3)
Post.create!(title: 'Fifth post', author: a3)

t1 = Tag.create!(name: 'news')
t2 = Tag.create!(name: 'tech')
t3 = Tag.create!(name: 'sport')

p1.tags << [t1, t2]
p2.tags << [t3]
