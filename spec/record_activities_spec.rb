require File.expand_path("spec_helper", File.dirname(__FILE__))

describe "recording activities" do
  before do
    User.stamper = User.create!
    Activity.delete_all
  end
  it "records an activity when a record is created" do
    lambda{Comment.create!(:text=>'x')}.should change(Activity,:count).by(+1)
  end
  it "does not record an activity when a record fails to e created" do
    lambda{Comment.create}.should change(Activity,:count).by(0)
  end
end