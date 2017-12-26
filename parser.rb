require './Matter.rb'
require './Level.rb'

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

def getParseLevel(levels)
	matter = []
	label = ""
	levels.each do |level|
		if /Plan:.*/.match(level).nil?  
			level = level.sub("(*)","").rstrip
			if level != ""
				matter << Matter.new(level)
			end
		else
			label = level.split('   ').last.strip
		end
	end
	Level.new(label, separateInMatter(matter))
end

def separateInMatter(lines)
	hashMatter = Hash.new
	hashGroup = Hash.new
	lines.each do |matter|
		name = matter.name.strip
		if (hashMatter[name].nil?)
			hashGroup = Hash.new
			hashGroup[matter.group] = matter
			hashMatter[name] = hashGroup
		else
			groups = hashMatter[name]
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
	file = File.new("419701.txt")
	resp = clean(file)
	levels = separeLevels(resp)
	levelsParsed = levels.map{|level| getParseLevel(level)}
end

levels = parseSchedule