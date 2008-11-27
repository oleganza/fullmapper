require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
FM = FullMapper
describe FullMapper do
  
  before(:each) do
    
    
    
    module FatModel
      include FM::Resource
      
      property :id, String, :default => proc{ rand(2**128).to_s(16) }
      key [ :id ]
      
    end
      
    class Person
      include FatModel
      
      property :name, String
      property :email, String
      
      index [ :email ], :max => 6
      index [ :name ], :max => 6
      
      # implicit class name guessing as well as other numerous defaults
      # are to be extracted into separate "beautifying" modules (`super` is our savior)
      has_one  :profile, :class_name => "Profile", :key => [ :person_id ]
      has_many :projects, :class_name => "Project", :key => [ :owner_id ]
      
      belongs_to :account, :class_name => "Account", :key => [ :account_id ]
    end
    
    
    repo = SomeRepository.new
      
    # internal execution of the public model's methods
    repo.new(User, attributes = {})  # new on-memory instance 
    repo.all(User, options = {})     # find all instances
    repo.save(instance)              # save instance
    repo.destroy(instance)           # destroy instance
    repo.destroy(collection)         # destroy collection
    
    # helper wrapper:
    repo.thread_context do
      Person.new()
    end
    
    def repo.thread_context
      FM::Repository.push_thread_context_repo(self)
      yield
    ensure
      FM::Repository.pop_thread_context_repo
    end
    
    # Model#new (as well as others):
    def new(*args, &blk)
      FM::Repository.thread_context_repo.new(*args, &blk)
    end
    
  end
  
end