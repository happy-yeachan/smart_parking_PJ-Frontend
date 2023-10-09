import streamlit as st
from PIL import Image


def main():
    global flag

    st.write(
        f'<div style="display: flex; justify-content: center;">'
        f'<h1>주차장을 선택해 주세요</h1>'
        f'</div>'
        f'<br>'
        f'<br>',
        unsafe_allow_html=True
    )

    num_columns = 2
    columns = st.columns(num_columns)
    image_width = 250
    image_height = 170

    for i, image_path in enumerate(image_paths):
        with columns[i % num_columns]:
            image = Image.open(image_path[0])
            resized_image = image.resize((image_width, image_height))
            st.image(resized_image, caption=image_path[1], use_column_width=True)

            st.link_button("선택", image_path[2])


image_paths = [
    ("photos/국교 주차장.jpg", "국교 주차장", "/tmp1"),
    ("photos/랩실 앞 주차장.jpeg", "랩실 앞 주차장", "/tmp2"),
    ("photos/N11동 주차장.jpeg", "N11 주차장", "/tmp3"),
    ("photos/랩실 앞 주차장.jpeg", "랩실 앞 주차장", "/tmp4"),
    # 여기에 더 많은 이미지 파일 경로를 추가하세요.
]

main()
