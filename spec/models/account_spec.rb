require 'rails_helper'

RSpec.describe Account, type: :model do
  describe "validations" do 
    it { should validate_presence_of :subdomain }
    it { should validate_uniqueness_of :subdomain }
    it { should_not allow_value('test').for(:subdomain) }
    it { should_not allow_value('www').for(:subdomain) }
    it { should_not allow_value('test/').for(:subdomain) }
    it { should_not allow_value('.test').for(:subdomain) }
  end
  end
