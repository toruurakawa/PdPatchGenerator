class PdPatch
	attr_reader :objects
	attr_reader :arrays
	attr_reader :connections

	def initialize(w = 100, h = 100, filename = "name")
		@objects		= Array.new()
		@arrays 		= Array.new()
		@connections	= Array.new()

		@width =  w
		@height = h
		@raw = "#N canvas 100 100 " + @width.to_s() + " " + @height.to_s() + " 10;\n"
		@name = filename
	end

	def add_object(obj)
		objects.push(obj)
	end

	def add_array(array)
		arrays.push(array)
	end

	def add_connection(connection)
		connections.push(connection)
	end

	def save()
		combine()
		io = File.open(@name+".pd", "w")
		io.print(@raw)
		io.close()
	end

	def clear()
		@raw = "#N canvas 100 100 " + @width.to_s() + " " + @height.to_s() + " 10;\n"
	end

	def combine()
		for obj in objects
			if obj.class == PdObject
				@raw += "#X obj " + obj.x.to_s() + " " + obj.y.to_s() + " " + obj.name + ";\n"   
			end
			if obj.class == PdNum
				@raw += "#X floatatom " + obj.x.to_s() + " " + obj.y.to_s() + " 5 0 0 0 - - -;\n" 
			end
			if obj.class == PdMessage
				@raw += "#X msg " + obj.x.to_s() + " " + obj.y.to_s() + " " + obj.message + ";\n" 
			end
			if obj.class == PdBang
				@raw += "#X obj " + obj.x.to_s() + " " + obj.y.to_s() + " bng 15 250 0 empty empty empty 17 7 0 10 -262144 -1 -1;\n" 
			end
			if obj.class == PdToggle
				@raw += "#X obj " + obj.x.to_s() + " " + obj.y.to_s() + " tgl 0 empty empty empty 17 7 0 10 -262144 -1 -1 0 1;\n" 
			end
		end

		for c in connections
			# get indices of objects connected with
			out_i = 0
			in_i = 0
			i = 0
			for obj in objects
				if obj.id == c.objOut.id
					out_i = i
				elsif obj.id == c.objIn.id
					in_i = i
				end
				i = i + 1
			end
			@raw += "#X connect " + out_i.to_s() + " " + c.outletNum.to_s() + " " + in_i.to_s() + " " + c.inletNum.to_s() + ";\n"   
		end
	end
	private :combine

end

class PdObject
	@@num = 0
	attr_reader :x
	attr_reader :y
	attr_reader :name
	attr_reader :id

	def initialize(x = 0, y = 0, name = "0")
		@x 		= x
		@y 		= y
		@name	= name
		@id 	= @@num
		@@num 	= @@num + 1
	end
end

class PdNum < PdObject
	def initialize(x = 0, y = 0)
		@x 		= x
		@y 		= y
		@name	= "floatatom"
		@id 	= @@num
		@@num 	= @@num + 1
	end
end

class PdMessage < PdObject
	attr_reader :message
	def initialize(x = 0, y = 0, message = "message")
		@x 		= x
		@y 		= y
		@message = message
		@name	= "msg"
		@id 	= @@num
		@@num 	= @@num + 1
	end
end

class PdBang < PdObject
	def initialize(x = 0, y = 0)
		@x 		= x
		@y 		= y
		@name	= "bng"
		@id 	= @@num
		@@num 	= @@num + 1
	end
end

class PdToggle < PdObject
	def initialize(x = 0, y = 0)
		@x 		= x
		@y 		= y
		@name	= "tgl"
		@id 	= @@num
		@@num 	= @@num + 1
	end
end

class PdConnection
	attr_reader :objOut
	attr_reader :objIn
	attr_reader :outletNum
	attr_reader :inletNum

	def initialize(objOut, outletNum, objIn, inletNum)
		@objOut	= objOut
		@objIn 	= objIn
		@outletNum	= outletNum
		@inletNum	= inletNum
	end	
end
