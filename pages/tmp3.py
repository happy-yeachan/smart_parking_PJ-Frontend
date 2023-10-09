import streamlit as st
from PIL import Image

st.link_button("뒤로", "/")
image_paths = "photos/N11동 주차장.JPEG"
image = Image.open(image_paths)

st.image(image, caption=image_paths)