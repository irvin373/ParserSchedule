class Level
	@name
	@matters

	def initialize(name, matters)
		@name = name
		@matters = matters
    end
    
    def to_json
        keys = self.matters.keys
        self.parseMatter(self.matters[keys[0]])
    end

    def parseMatter(matters)
        keys = matters.keys
        
    end

	attr_accessor :name, :matters
end