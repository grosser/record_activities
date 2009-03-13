require File.expand_path("spec_helper", File.dirname(__FILE__))

describe :record_activities do
  before do
    Activity.delete_all
    Comment.delete_all
    Comment.record_userstamp = true
    User.stamper = User.create!
  end

  describe "basics" do
    def create_valid_comment
      Comment.create!(:text=>'x')
    end

    it "records an activity when a record is created" do
      lambda{create_valid_comment}.should change(Activity,:count).by(+1)
    end

    it "does not record an activity when a record fails to be created" do
      lambda{Comment.create}.should change(Activity,:count).by(0)
    end

    it "does not record an activity when record_userstamp is set to false" do
      Comment.record_userstamp = false
      lambda{create_valid_comment}.should change(Activity,:count).by(0)
    end
  end

  describe 'validations' do
    subject {Activity.new(:action=>'something')}
    it {should be_valid}

    it "is not valid without an action" do
      subject.action=nil
      should_not be_valid
    end
  end

  describe 'has many activities' do
    it "associated has many activities" do
      Comment2.new.activities.should == []
    end

    it "associated has many custom named activities" do
      Comment3.new.things_i_did.should == []
    end
  end

  describe "storing" do
    before do
      Comment.create!(:text=>'x')
    end

    it "records with current stamper as actor" do
      Activity.first.actor.id.should == User.stamper
    end

    it "records the action being performed" do
      Comment.first.save!
      Activity.last.action.should == 'update'
    end

    it "records the subject as the item being changed" do
      Activity.first.subject.should == Comment.first
    end
  end

  describe "recording custom activities" do
    it "does not store default activities" do
      lambda{Comment2.create!(:text=>'x')}.should_not change(Activity,:count)
    end

    it "stores custom activities" do
      c = Comment2.create!(:text=>'x')
      lambda{c.record_activity_foo}.should change(Activity,:count).by(+1)
    end

    it "stores custom actions" do
      c = Comment2.create!(:text=>'x')
      c.record_activity_foo
      Activity.first.action.should == 'foo'
    end
  end

  describe "destroying a subject" do
    it "removes all activities" do
      x = Comment2.create!(:text=>'x')
      x.record_activity_foo
      lambda{x.destroy}.should change(Activity,:count).by(-1)
    end
  end
end