require 'json'
require 'data_mapper'
require 'unicorn'
require 'sinatra'
require 'newrelic_rpm'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/notecard.db")

class NoteCard
	include DataMapper::Resource
	property :id, Serial
	property :term, Text, :required => true
	property :definition, Text, :required => true	
	property :complete, Boolean, :required => true, :default => false
	property :created_at, DateTime
	property :updated_at, DateTime
end

DataMapper.finalize.auto_upgrade!

# note = NoteCard.new term: "Rspec", definition: "A behavior-driven development (BDD) framework for Ruby", created_at: Time.now
# note.save

get '/' do
	@notecards = NoteCard.all :order => :id.desc
	erb :home
end

get '/notecards' do
	@notecards = NoteCard.all :order => :id.desc
	erb :notecards
end








