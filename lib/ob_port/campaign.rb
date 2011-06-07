module MageHand
  class Campaign < Base
    ROLES = {'game_master' => 'Game Master', 'player' => 'Player'}
    
    # public mini-object methods
    attr_accessor :name, :campaign_url, :role, :visibility
    
    attr_accessor :slug
    attr_instance :game_master, :class_name => 'User'
    inflate_if_nil :game_master, :slug
    
    # Private/Friends
    attr_accessor :banner_image_url, :play_status, :looking_for_players, :created_at, :updated_at
    inflate_if_nil :banner_image_url, :play_status, :looking_for_players, :created_at, :updated_at
    
    # Player/GM Only
    attr_accessor :lat, :lng
    inflate_if_nil :lat, :lng
    
    attr_array :players, :class_name => 'User'
    inflate_if_nil :players

    def self.find_by_slug(slug)
      hash = JSON.parse( MageHand::get_client.access_token.get("/v1/campaigns/#{slug}.json?use_slug=true").body)
      Campaign.new(hash)
    end

    def self.find(id)
      hash = JSON.parse( MageHand::get_client.access_token.get("/v1/campaigns/#{id}.json").body)
      Campaign.new(hash)
    end
    
    def looking_for_players?
      looking_for_players
    end
    
    def role_as_title_string
      ROLES[self.role]
    end
    
    def wiki_pages
      @wiki_pages ||= MageHand::WikiPage.load_wiki_pages(self.id)
    end
    
     def posts
       @adventure_logs ||= wiki_pages.select{|page| page.is_post?}
     end
     
     protected

     def individual_url
       "/v1/campaigns/#{self.id}.json"
     end
  end
end