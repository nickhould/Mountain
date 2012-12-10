class StaticpagesController < ApplicationController

	before_filter :create_garb_session, only: :test
	
	def home
	end

	def login
	end

	def about
	end

	def test
	end

	def demo
	end
end
