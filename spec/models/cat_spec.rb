require 'rails_helper'

RSpec.describe Cat, type: :model do
  it 'validates presence of name' do
    cat = Cat.create age:10, enjoys:'long bouts at fight club', image:'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'

    expect(cat.errors[:name]).to_not be_empty
  end
  it 'validates presence of age' do
    cat = Cat.create name:'scrap', enjoys:'long bouts at fight club', image:'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'

    expect(cat.errors[:age]).to_not be_empty
  end
  it 'validates presence of enjoys' do
    cat = Cat.create name:'scrap', age:10, image:'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'

    expect(cat.errors[:enjoys]).to_not be_empty
  end
  it 'validates presence of image' do
    cat = Cat.create name:'scrap', age:10, enjoys:'long bouts at fight club'

    expect(cat.errors[:image]).to_not be_empty
  end
  it 'validates enjoys is at least 10 characters' do
    cat = Cat.create name:'scrap', age:10, enjoys:'fightclub', image:'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'

    expect(cat.errors[:enjoys]).to_not be_empty
  end
end
