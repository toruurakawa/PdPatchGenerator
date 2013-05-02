class PdPatchCanvas
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

	def clear()
		@raw = "#N canvas 100 100 " + @width.to_s() + " " + @height.to_s() + " 10;\n"
	end

	def save()
		self.conbine()
		io = File.open(@name+".pd", "w")
		io.print(@raw)
		io.close()
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

	def conbine()
		for obj in objects
			@raw += "#X obj " + obj.x.to_s() + " " + obj.y.to_s() + " " + obj.name + ";\n"   
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

end

class PDObject
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

class PDConnection
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



canvas = PdPatchCanvas.new(300, 300, "test")

obj0 = PDObject.new(50, 50, "osc~")
obj1 = PDObject.new(100, 100, "dac~")

connection0 = PDConnection.new(obj0, 0, obj1, 0)
connection1 = PDConnection.new(obj0, 0, obj1, 1)

canvas.add_object(obj0)
canvas.add_object(obj1)
canvas.add_connection(connection0)
canvas.add_connection(connection1)
canvas.save()
