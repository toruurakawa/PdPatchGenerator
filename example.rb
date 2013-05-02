require 'PdPatchGenerator'

canvas = PdPatchCanvas.new(300, 300, "test")

obj0 = PdObject.new(50, 50, "osc~")
obj1 = PdObject.new(100, 100, "dac~")

connection0 = PdConnection.new(obj0, 0, obj1, 0)
connection1 = PdConnection.new(obj0, 0, obj1, 1)

canvas.add_object(obj0)
canvas.add_object(obj1)

num0 = PdNum.new(50, 10)
canvas.add_object(num0)
connection2 = PdConnection.new(num0, 0, obj0, 0)

message0 = PdMessage.new(100,30)
canvas.add_object(message0)
connection3 = PdConnection.new(message0, 0, obj0, 1)

canvas.add_connection(connection0)
canvas.add_connection(connection1)
canvas.add_connection(connection2)
canvas.add_connection(connection3)

canvas.add_object(message0)

bang = PdBang.new(200, 50)
canvas.add_object(bang)
canvas.add_connection(PdConnection.new(bang, 0, obj1, 0))

canvas.save()