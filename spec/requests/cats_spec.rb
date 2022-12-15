require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it "gets a list of cats" do
      Cat.create(
        name: 'Felix',
        age: 2,
        enjoys: 'Walks in the park',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )

      get '/cats'

      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat.length).to eq 1
    end
  end


  describe "POST /create" do
    it "creates a cat" do

      cat_params = {
        cat: {
          name: 'Buster',
          age: 4,
          enjoys: 'Meow Mix, and plenty of sunshine.',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }
  
      post '/cats', params: cat_params
      expect(response).to have_http_status(200)  
      cat = Cat.first
      expect(cat.name).to eq 'Buster'
    end
    it "doesn't create a cat without a name" do

      cat_params = {
        cat: {
          age: 4,
          enjoys: 'Meow Mix, and plenty of sunshine.',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }
  
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)  
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to include "can't be blank"
    end
    it "cdoesn't create a cat without an age" do

      cat_params = {
        cat: {
          name: 'Buster',
          enjoys: 'Meow Mix, and plenty of sunshine.',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }
  
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)  
      json_response = JSON.parse(response.body)
      expect(json_response['age']).to include "can't be blank"
    end
    it "doesn't create a cat without an enjoys" do

      cat_params = {
        cat: {
          name: 'Buster',
          age: 4,
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }
  
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)  
      json_response = JSON.parse(response.body)
      expect(json_response['enjoys']).to include "can't be blank"
    end
    it "doesn't create a cat without an image" do

      cat_params = {
        cat: {
          name: 'Buster',
          age: 4,
          enjoys: 'Meow Mix, and plenty of sunshine.',
        }
      }
  
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)  
      json_response = JSON.parse(response.body)
      expect(json_response['image']).to include "can't be blank"
    end
    it "doesn't create a cat with enjoys less than 10 characters long" do

      cat_params = {
        cat: {
          name: 'Buster',
          age: 4,
          enjoys: 'Meow',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }
  
      post '/cats', params: cat_params
      expect(response).to have_http_status(422)  
      json_response = JSON.parse(response.body)
      expect(json_response['enjoys']).to include "is too short (minimum is 10 characters)"
    end
  end


  describe "PATCH /update" do
    it "updates a cat" do
      cat = Cat.create(name: 'Buster',
      age: 4,
      enjoys: 'Meow Mix, and plenty of sunshine.',
      image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80')
      cat_params = {
        cat: {
          name: 'Buster',
          age: 5,
          enjoys: 'Meow Mix, and plenty of sunshine.',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }

      patch "/cats/#{cat.id}", params: cat_params
      updated_cat = Cat.find(cat.id)
      expect(response).to have_http_status(200)
      expect(updated_cat.age).to eq 5
    end
    it 'cannot update a cat at particular ID without a name' do
      Cat.create name:'Billiam', age:10, enjoys:'The finest catnip', image:'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      cat_params = {
        cat: {
          name: nil,
          age: 8,
          enjoys:'The finest catnip',
          image:'I swear this is an image'
        }
      }

      cat = Cat.last
      patch "/cats/#{cat.id}", params: cat_params
      expect(response).to have_http_status(422)
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to include "can't be blank"
    end
    it 'cannot update a cat at particular ID without an age' do
      Cat.create name:'Billiam', age:10, enjoys:'The finest catnip', image:'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      cat_params = {
        cat: {
          name: 'Billiam',
          age: nil,
          enjoys:'The finest catnip',
          image:'I swear this is an image'
        }
      }

      cat = Cat.last
      patch "/cats/#{cat.id}", params: cat_params
      expect(response).to have_http_status(422)
      json_response = JSON.parse(response.body)
      expect(json_response['age']).to include "can't be blank"
    end
    it 'cannot update a cat at particular ID without an enjoys' do
      Cat.create name:'Billiam', age:10, enjoys:'The finest catnip', image:'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      cat_params = {
        cat: {
          name: 'Billiam',
          age: 8,
          enjoys: nil,
          image:'I swear this is an image'
        }
      }

      cat = Cat.last
      patch "/cats/#{cat.id}", params: cat_params
      expect(response).to have_http_status(422)
      json_response = JSON.parse(response.body)
      expect(json_response['enjoys']).to include "can't be blank"
    end
    it 'cannot update a cat at particular ID without an image' do
      Cat.create name:'Billiam', age:10, enjoys:'The finest catnip', image:'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      cat_params = {
        cat: {
          name: 'Billiam',
          age: 8,
          enjoys:'The finest catnip',
          image: nil
        }
      }

      cat = Cat.last
      patch "/cats/#{cat.id}", params: cat_params
      expect(response).to have_http_status(422)
      json_response = JSON.parse(response.body)
      expect(json_response['image']).to include "can't be blank"
    end
    it 'cannot update a cat at particular ID with an enjoys less than 10 characters long' do
      Cat.create name:'Billiam', age:10, enjoys:'The finest catnip', image:'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      cat_params = {
        cat: {
          name: 'Billiam',
          age: 8,
          enjoys:'catnip',
          image:'I swear this is an image'
        }
      }

      cat = Cat.last
      patch "/cats/#{cat.id}", params: cat_params
      expect(response).to have_http_status(422)
      json_response = JSON.parse(response.body)
      expect(json_response['enjoys']).to include "is too short (minimum is 10 characters)"
    end
  end


  describe "DELETE /destroy" do
    it "deletes da poor cat" do
      Cat.create(name: 'Buster',
      age: 4,
      enjoys: 'Meow Mix, and plenty of sunshine.',
      image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80')
      cat = Cat.last
      delete "/cats/#{cat.id}"

      expect(response).to have_http_status(200)
      expect(Cat.all).to be_empty
    end
  end
end
