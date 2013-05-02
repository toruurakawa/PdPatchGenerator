require 'PdPatchGenerator'

canvas = PdPatchCanvas.new(300, 300, "test")

obj0 = PdObject.new(50, 50, "osc~")
obj1 = PdObject.new(100, 100, "dac~")

connection0 = PdConnection.new(obj0, 0, obj1, 0)
connection1 = PdConnection.new(obj0, 0, obj1, 1)

canvas.add_object(obj0)
canvas.add_object(obj1)
canvas.add_connection(connection0)
canvas.add_connection(connection1)
canvas.save()