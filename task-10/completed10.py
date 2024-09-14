from PIL import Image, ImageDraw
import cv2
import glob
import re

def perfect(text):
    # Helper function to sort filenames by the number.
    return [int(c) if c.isdigit() else c for c in re.split(r'(\d+)', text)]

# Create a blank canvas (512x512) to draw on
canvas_size = (512, 512)
output_image = Image.new("RGB", canvas_size, "white")
draw = ImageDraw.Draw(output_image)

# Get all images in the directory and sort them
img_paths = sorted(glob.glob("/home/anandajith-s/amfoss-tasks/task-10/Operation-Pixel-Merge/assets/*.png"), key=perfect)
previous_coords = None
for pic in img_paths:
    picture = cv2.imread(pic)
    if picture is None:
        print("None")
        continue
    
    height, width, _ = picture.shape
    found_dot = False

    for i in range(height):
        for j in range(width):
            (B, G, R) = picture[i, j]
            if R != 255 or G !=255 or B != 255: # Checks if the pixel is white or not
                if previous_coords==None:
                    previous_coords=(j,i) #j correspondes to x-coordinate and i correspondes to y-coordinate
                    found_dot=True
                    break
                else:
                    vertices=[previous_coords,(j,i)]
                    draw.line(vertices,fill=(R,G,B),width=5)
                    previous_coords=(j,i)
                    found_dot=True
                    break
    if found_dot==False:
        previous_coords=None

# Save and display the final image
output_image.save("amfoss1.png")
output_image.show()
