class Matter
	@code
	@name
	@group
	@teacher
	@schedule
	@days
	def initialize(line)
		@code = ""
		@name = ""
		@group = ""
		@teacher = ""
		@days = []
		@schedule = []
		self.getMatter(line)
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

	def show
		puts "#{@code} #{@name} #{@group} #{@days} #{@teacher} #{@schedule}"
	end

	def addDetail(matter)
		@days << matter.days
		@schedule << matter.schedule
	end

	def getMatter(line)
		details = line.split.reverse
		@code = temp = details.pop
		begin
		  temp = details.pop
		  if /\d/.match(temp) == nil
		  	@name += " " + temp
		  end
		end while /\d/.match(temp) == nil
		@group = temp
		@days << details.pop
		@schedule << details.pop
		begin
		  temp = details.pop
		  @teacher += " " + temp
		end while details != []
	end

	attr_accessor :code,:name,:group,:teacher,:schedule, :days
end

def test
	line = "1803001 INGLES I                                    1    LU 815-945(617)        CESPEDES GUIZADA MARIA BENITA\r\n"
	line2 ="1803001 INGLES I                                    1    VI 815-945(691D)       CESPEDES GUIZADA MARIA BENITA"
	line3 ="1803001 INGLES I                                    2    MA 1115-1245(690D)     CESPEDES GUIZADA MARIA BENITA"
	line4 ="2006018 FISICA BASICA I                             1    LU 1715-1845(617)      CASTRO LAZARTE CECILIA BEATRIZ"
	line5 ="2006018 FISICA BASICA I                             2    LU 1715-1845(617)      CASTRO LAZARTE CECILIA BEATRIZ"
	matter = Matter.new(line)
	matter2 = Matter.new(line2)
	matter3 = Matter.new(line3)
	matter4 = Matter.new(line4)
	matter5 = Matter.new(line5)

	lines = []
	lines << matter
	lines << matter2
	lines << matter3
	lines << matter4
	lines << matter5

	matterTemp = []
	answer = []

	first = lines.pop
	i = 0
	while lines != []
		matterTemp << first
		iterator = lines.pop
		while first == iterator
			matterTemp << iterator
			iterator = lines.pop
		end
		first = iterator
		answer << matterTemp
		matterTemp = []
	end 
	answer
end

matter = test
matter.each do |m|
	m.map{|x| x.show}
end