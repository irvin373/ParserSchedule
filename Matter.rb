class Matter
	@code
	@name
	@group
	@teacher
	@schedule
	def initialize(line)
		@code = ""
		@name = ""
		@group = ""
		@teacher = ""
		@days = []
		@schedule = []
		self.getMatter(line)
	end

	def show
		puts @code
		puts @name
		puts @group
		puts @days
		puts @teacher
		puts @schedule
	end

	def getMatter(line)
		details = line.split.reverse
		@code = temp = details.pop
		begin
		  temp = details.pop
		  if /\d/.match(temp) == nil
		  	@name += " " + temp.strip
		  end
		end while /\d/.match(temp) == nil
		@group = temp
		@days << details.pop
		@schedule << details.pop
		begin
		  temp = details.pop
		  @teacher += " " + temp.strip
		end while details != []
	end

	def !=(y)
	   !(self == y)
	end

	def ==(y)
		if y.nil?
			return false
		end
	   return self.code == y.code && self.name == y.name
	end

	def ===(y)
	   self == y && self.group == y.group
	end

	def to_json
		return "{code: #{self.code}, name: #{self.name}, group: #{self.group}, teacher: #{self.teacher}, days: #{self.days}, schedule: #{self.schedule}}"
	end

	attr_accessor :code,:name,:group,:teacher,:schedule, :days
end