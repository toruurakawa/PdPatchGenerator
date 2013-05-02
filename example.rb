require 'PdPatchGenerator'

patch = PdPatch.new(300, 300, "test")

obj0 = PdObject.new(50, 50, "osc~")
obj1 = PdObject.new(100, 100, "dac~")

connection0 = PdConnection.new(obj0, 0, obj1, 0)
connection1 = PdConnection.new(obj0, 0, obj1, 1)

patch.add_object(obj0)
patch.add_object(obj1)

num0 = PdNum.new(50, 10)
patch.add_object(num0)
connection2 = PdConnection.new(num0, 0, obj0, 0)

message0 = PdMessage.new(100,30)
patch.add_object(message0)
connection3 = PdConnection.new(message0, 0, obj0, 1)

patch.add_connection(connection0)
patch.add_connection(connection1)
patch.add_connection(connection2)
patch.add_connection(connection3)

patch.add_object(message0)

bang = PdBang.new(200, 50)
patch.add_object(bang)
patch.add_connection(PdConnection.new(bang, 0, obj1, 0))

toggle = PdToggle.new(200,80)
patch.add_object(toggle)

patch.save()