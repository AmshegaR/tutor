from tkinter import *

canvas_width = 700
canvas_height = 500
brush_size = 3
color = "black"

def paint(event):
    global brush_size
    global color
    x1 = event.x - brush_size
    x2 = event.x + brush_size
    y1 = event.y - brush_size
    y2 = event.y + brush_size
    w.create_oval(x1, y1, x2, y2,
                  fill=color, outline=color)

def brush_size_change(new_size):
    global brush_size
    brush_size = new_size

def color_change(new_color):
    global color
    color = new_color
    
root = Tk()
root.title("PyPaint")

w = Canvas(root, 
           width=canvas_width,
           height=canvas_height,
           bg="white")
w.bind("<B1-Motion>", paint)

red_btn = Button(text="Red", width=10,
                 command=lambda: color_change("Red"))
blue_btn = Button(text="Blue", width=10,
                 command=lambda: color_change("Blue"))
black_btn = Button(text="Black", width=10,
                 command=lambda: color_change("Black"))
white_btn = Button(text="White", width=10,
                 command=lambda: color_change("White"))
clear_btn = Button(text="Clear", width=10,
                 command=lambda: w.delete("all"))

one_btn = Button(text="1px", width=10,
                  command=lambda: brush_size_change(1))                 
five_btn = Button(text="5px", width=10,
                  command=lambda: brush_size_change(5))
ten_btn = Button(text="10px", width=10,
                  command=lambda: brush_size_change(10))
twelve_btn = Button(text="12px", width=10,
                  command=lambda: brush_size_change(12))
fifteen_btn = Button(text="15px", width=10,
                  command=lambda: brush_size_change(15))

w.grid(row=2, column=0,
       columnspan=7, padx=5,
       pady=5, sticky=E+W+S+N)
w.columnconfigure(6, weight=1)
w.rowconfigure(2, weight=1)

red_btn.grid(row=0, column=2)
blue_btn.grid(row=0, column=3)
black_btn.grid(row=0, column=4)
white_btn.grid(row=0, column=5)
clear_btn.grid(row=0, column=6)

one_btn.grid(row=1, column=2)
five_btn.grid(row=1, column=3)
ten_btn.grid(row=1, column=4)
twelve_btn.grid(row=1, column=5)
fifteen_btn.grid(row=1, column=6)
root.mainloop()