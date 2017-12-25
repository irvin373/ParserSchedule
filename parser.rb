class Level
	@name
	@matters

	def initialize(name, matters)
		@name = name
		@matters = matters
	end

	attr_accessor :name, :matters
end

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

def clean(file)
    resp = []
    regex = /Horario de Clases.*|.Elaborado por el Centro.*|SisMat.*/
    while !file.eof
	    line = file.gets
	    if regex.match(line) == nil and line != "\r\n"
		    resp << line
	    end
    end
    return resp	
end

def separeLevels(file)
	regex = /.*Si encuentra.*/
	levels = []
	level = []
	file.each do |line|
		if regex.match(line) != nil
			levels << level
			level = []
		else
			level << line
		end
	end
	return levels
end

# def getFist
# 	matter = []
# 	file = File.new("419701.txt")
# 	resp = clean(file)
# 	levels = separeLevels(resp) 
	
# 	levels = levels.first
	
# 	levels.each do |level|
# 		if /Plan:.*/.match(level).nil?  
# 			level = level.sub("(*)","").rstrip
# 			if level != ""
# 				matter << Matter.new(level)
# 			end
# 		end
# 	end
# 	matter
# end

def getParseLevel(level)
	matter = []
	levels.each do |level|
		if /Plan:.*/.match(level).nil?  
			level = level.sub("(*)","").rstrip
			if level != ""
				matter << Matter.new(level)
			end
		else
			label = split('   ').last.strip
		end
	end
	Level.new(label, matter)
end

def separateInMatter(lines)
	hashMatter = Hash.new
	hashGroup = Hash.new
	lines.each do |matter|
		if (hashMatter[matter.code].nil?)
			hashGroup = Hash.new
			hashGroup[matter.group] = matter
			hashMatter[matter.code] = hashGroup
		else
			groups = hashMatter[matter.code]
			if(groups[matter.group].nil?)
				groups[matter.group] = matter
			else
				group = groups[matter.group]
				group.days << matter.days.first
				group.schedule << matter.schedule.first
			end
		end
	end
	hashMatter
end

def parseSchedule
	levelsParsed = []
	file = File.new("419701.txt")
	resp = clean(file)
	levels = separeLevels(resp) 
	levels.each do |level|
		levelsParsed << getParseLevel(level)
	end
	levelsParsed
end

# puts getFist
# primer = separateInMatter(getFist)
# puts primer
# parseSchedule