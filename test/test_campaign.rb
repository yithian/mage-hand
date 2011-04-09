require 'test/helper'

class TestCampaign < Test::Unit::TestCase
  context 'an instance of the Campaign class' do
    should 'know its url' do
      id_string = 'asdf12341asdf1234'
      campaign = MageHand::Campaign.new(:id => id_string)
      assert_equal "/v1/campaigns/#{id_string}.json", campaign.send(:individual_url)
    end
  end
  
  context 'the Campaign class' do
    setup do
      @mini_fields = {
        :id => 'asdf12341asdf1234',
        :name => 'Fellowship of the Ring',
        :campaign_url => 'http://www.obsidianportal.com/campaigns/fellowship-of-the-ring',
        :visibility => 'public',
        :role => 'player'
      }
      @full_fields = @mini_fields.merge(
        :slug => 'FotR',
        :play_status => 'active',
        :looking_for_players => false
      )
    end
    
    should 'be able to initialize from a mini object' do
      campaign = MageHand::Campaign.new(@mini_fields)
      assert_not_nil campaign
      @mini_fields.each do |key, value|
        assert_equal campaign.send(key), value
      end
    end
    
    should 'be able to initialize from a complete object' do
      campaign = MageHand::Campaign.new(@full_fields)
      assert_not_nil campaign
      @full_fields.each do |key, value|
        assert_equal campaign.send(key), value
      end     
    end
  end
end