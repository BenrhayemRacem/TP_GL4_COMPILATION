import tkinter as tk
import subprocess


def run_command():
    program = text_field.get("1.0", 'end-1c')

    with open("test.txt", "w") as f:
        f.write(program)

    command = ".\\test.exe .\\test.txt"
    output = subprocess.check_output(command, stderr=subprocess.STDOUT, universal_newlines=True)

    result_field.insert(tk.END, output)


root = tk.Tk()
root.title("Mini java Compiler")

text_label = tk.Label(root, text="Enter Program")
text_label.pack()

text_field = tk.Text(root, width=100, height=20)
text_field.pack()

run_button = tk.Button(root, text="COMPILE", command=run_command)
run_button.pack()

result_label = tk.Label(root, text="Results:")
result_label.pack()

result_field = tk.Text(root)
result_field.pack()

root.mainloop()
