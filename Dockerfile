FROM python:3.11-slim

WORKDIR /app

# 시스템 의존성 (Pillow, torch 등 대비)
RUN apt-get update && apt-get install -y \
    build-essential \
    libgl1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# requirements 설치
COPY requirement.txt .
RUN pip install --no-cache-dir -r requirement.txt

# 소스 복사
COPY . .

# FastAPI 실행
CMD ["uvicorn", "api.app:app", "--host", "0.0.0.0", "--port", "8000"]