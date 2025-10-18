from typing import Optional
import os

# Try to use pydantic-settings (preferred). If it's not available (for example,
# when running with pydantic v1 or a Python version without prebuilt wheels),
# fall back to a lightweight dotenv-based loader so the app can still run.
try:
    from pydantic_settings import BaseSettings

    class Settings(BaseSettings):
        # Supabase
        SUPABASE_URL: str
        SUPABASE_KEY: str
        SUPABASE_SERVICE_ROLE_KEY: str

        # JWT
        SECRET_KEY: str
        ALGORITHM: str = "HS256"
        ACCESS_TOKEN_EXPIRE_MINUTES: int = 30
        REFRESH_TOKEN_EXPIRE_DAYS: int = 7

        # Gemini AI
        GEMINI_API_KEY: Optional[str] = None

        # CORS
        FRONTEND_URL: str = "http://localhost:5173"

        class Config:
            env_file = ".env"

    settings = Settings()
except Exception:
    # Fallback path: use python-dotenv (if available) or os.environ directly.
    try:
        from dotenv import load_dotenv
        load_dotenv()
    except Exception:
        # If python-dotenv isn't installed, we just rely on existing env vars.
        pass

    class Settings:
        # Supabase
        SUPABASE_URL: Optional[str] = os.getenv("SUPABASE_URL")
        SUPABASE_KEY: Optional[str] = os.getenv("SUPABASE_KEY")
        SUPABASE_SERVICE_ROLE_KEY: Optional[str] = os.getenv("SUPABASE_SERVICE_ROLE_KEY")

        # JWT
        SECRET_KEY: Optional[str] = os.getenv("SECRET_KEY")
        ALGORITHM: str = os.getenv("ALGORITHM", "HS256")
        ACCESS_TOKEN_EXPIRE_MINUTES: int = int(os.getenv("ACCESS_TOKEN_EXPIRE_MINUTES", "30"))
        REFRESH_TOKEN_EXPIRE_DAYS: int = int(os.getenv("REFRESH_TOKEN_EXPIRE_DAYS", "7"))

        # Gemini AI
        GEMINI_API_KEY: Optional[str] = os.getenv("GEMINI_API_KEY")

        # CORS
        FRONTEND_URL: str = os.getenv("FRONTEND_URL", "http://localhost:5173")

    settings = Settings()
