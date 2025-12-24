## Quick Start (로컬 실행 / 백엔드 확인용)

### 1. 환경 준비
```bash
# Python 3.10 권장
conda create -n reskin-ai python=3.10 -y
conda activate reskin-ai

pip install -r requirement.txt
```

### 2. 서버 실행
```bash
# CPU 강제 실행 (GPU 없는 환경에서도 가능)
RESKIN_DEVICE=cpu python -m uvicorn api.app:app --reload

GPU 사용 
RESKIN_DEVICE=cuda python -m uvicorn api.app:app --reload
```

### 3. 테스트
Swagger UI: http://127.0.0.1:8000/docs
