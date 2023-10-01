import streamlit as st
from PIL import Image

st.write(
    f'<div style="display: flex; justify-content: center;">'
    f'<h1>주차장을 선택해 주세요</h1>'
    f'</div>'
    f'<br>'
    f'<br>',
    unsafe_allow_html=True
)

# 이미지 파일 경로 리스트
image_paths = [
    ("photos/국교 주차장.jpg", "국교 주차장"),
    ("photos/랩실 앞 주차장.jpeg", "랩실 앞 주차장"),
    ("photos/N11동 주차장.jpeg", "N11 주차장"),
    ("photos/랩실 앞 주차장.jpeg", "랩실 앞 주차장"),
    # 여기에 더 많은 이미지 파일 경로를 추가하세요.
]

# 열의 수 (바둑판 형식으로 배치하기 위해 조절)
num_columns = 2

# 열을 생성
columns = st.columns(num_columns)

# 고정된 이미지 크기
image_width = 250
image_height = 170

for i, image_path in enumerate(image_paths):
    # 이미지 열
    with columns[i % num_columns]:
        # 이미지 파일을 열어 크기 조정
        image = Image.open(image_path[0])
        
        # 이미지를 원하는 크기로 조정하고 화면에 표시
        resized_image = image.resize((image_width, image_height))
        st.image(resized_image, caption=image_path[1], use_column_width=True)

        # 버튼을 가운데 정렬하도록 CSS 스타일 적용
        st.write(
            f'<div style="display: flex; justify-content: center;">'
            f'<button style="width: 100px;">선택</button>'
            f'</div>'
            f'<br>'
            f'<br>',
            unsafe_allow_html=True
        )
