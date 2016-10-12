require "spec_helper"

describe Crease do

  let(:_) do
    class MyModuleWrapper
      include Crease::TextHelpers
    end
    MyModuleWrapper.new
  end

  it "has a version number" do
    expect(Crease::VERSION).not_to be nil
  end

  describe "increased by" do
    context "one number" do
      it "positive" do
        _.increased.by(1).to_s.should == 'increased by 1.0'
      end

      it "negative" do
        _.increased.by(-100).to_s.should == 'decreased by 100.0'
      end
    end

    context "two numbers" do
      it "increasing" do
        _.increased.by(2, 4).to_s.should == 'increased by 2.0'
      end

      it "decreasing" do
        _.increased.by(3, 2).to_s.should == 'decreased by 1.0'
      end
    end
  end

  # TODO: Dry me up
  describe "decreased by" do
    context "one number" do
      it "positive" do
        _.decreased.by(1).to_s.should == 'increased by 1.0'
      end

      it "negative" do
        _.decreased.by(-100).to_s.should == 'decreased by 100.0'
      end
    end

    context "two numbers" do
      it "increasing" do
        _.decreased.by(2, 4).to_s.should == 'increased by 2.0'
      end

      it "decreasing" do
        _.decreased.by(3, 2).to_s.should == 'decreased by 1.0'
      end
    end
  end

  describe "increased or decreased by percent" do

    context "one number" do
      it "positive" do
        _.increased.by(1).percent.to_s.should == 'increased by 1.0%'
      end

      it "negative" do
        _.increased.by(-1).percent.to_s.should == 'decreased by 1.0%'
      end
    end

    context "two numbers" do
      it "increasing" do
        _.decreased.by(2, 4).percent.to_s.should == 'increased by 200.0%'
      end

      it "decreasing" do
        _.increased.by(3, 2).percent.to_s.should == 'decreased by 33.33%'
      end

      pending "next version" do
        # This should be a 5% increase and a N% *change*.
        _.decreased.by(590_433, 620_451).percent.to_s.should == 'increased by 5.1%'
      end
    end

  end

  describe "an increase or a decrease" do

    context "one number" do
      it "describes with an article" do
        _.an.increase.of(2).to_s.should  == 'an increase of 2.0'
        _.a.decrease.of(2).to_s.should   == 'an increase of 2.0'
        _.an.increase.of(-2).to_s.should == 'a decrease of 2.0'
        _.a.decrease.of(-2).to_s.should  == 'a decrease of 2.0'
      end
    end

    context "two numbers" do
      it "describes with an article" do
        _.a.decrease.of(1, 2).to_s.should == 'an increase of 1.0'
        _.a.increase.of(2, 1).percent.to_s.should == 'a decrease of 50.0%'
      end
    end

  end

end
