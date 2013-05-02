require 'PdPatchGenerator'
	
patch = PdPatch.new(1050, 200, "test")

for i in 0...5
    obj0 = PdObject.new(50+200*i, 50, "osc~")
	obj1 = PdObject.new(100+200*i, 100, "dac~")

	connection0 = PdConnection.new(obj0, 0, obj1, 0)
	connection1 = PdConnection.new(obj0, 0, obj1, 1)

	patch.add_object(obj0)
	patch.add_object(obj1)

	num0 = PdNum.new(50+200*i, 10)
	patch.add_object(num0)
	connection2 = PdConnection.new(num0, 0, obj0, 0)

	message0 = PdMessage.new(100+200*i,30)
	patch.add_object(message0)
	connection3 = PdConnection.new(message0, 0, obj0, 1)

	patch.add_connection(connection0)
	patch.add_connection(connection1)
	patch.add_connection(connection2)
	patch.add_connection(connection3)

	patch.add_object(message0)

	bang = PdBang.new(200+200*i, 50)
	patch.add_object(bang)
	patch.add_connection(PdConnection.new(bang, 0, obj1, 0))

	toggle = PdToggle.new(200+200*i,80)
	patch.add_object(toggle)
    
    array = PdArray.new(50+200*i, 150)
    patch.add_object(array)

end

patch.save()