from fastapi import APIRouter, HTTPException, status, Depends
from datetime import timedelta
from schemas import UserRegister, UserLogin, TokenResponse, TokenRefresh, UserRole
from auth import hash_password, verify_password, create_access_token, create_refresh_token, get_current_user
from database import get_supabase
from supabase import Client

router = APIRouter(prefix="/api/auth", tags=["auth"])

@router.post("/register", response_model=TokenResponse)
async def register(user_data: UserRegister, supabase: Client = Depends(get_supabase)):
    try:
        # Check if user already exists
        existing = supabase.table("users").select("*").eq("email", user_data.email).execute()
        if existing.data:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Email already registered")
        
        # Create user
        hashed_password = hash_password(user_data.password)
        user_response = supabase.table("users").insert({
            "email": user_data.email,
            "password_hash": hashed_password,
            "full_name": user_data.full_name,
            "phone_number": user_data.phone_number,
            "role": user_data.role.value,
            "is_active": True
        }).execute()
        
        user_id = user_response.data[0]["user_id"]
        
        # Create role-specific records
        if user_data.role == UserRole.DOCTOR:
            supabase.table("doctors").insert({
                "user_id": user_id,
                "specialization": "General",
                "license_number": "TEMP-" + user_id[:8]
            }).execute()
        elif user_data.role == UserRole.PATIENT:
            supabase.table("patients").insert({
                "user_id": user_id
            }).execute()
        elif user_data.role == UserRole.PHARMACY:
            supabase.table("pharmacies").insert({
                "user_id": user_id,
                "pharmacy_name": "New Pharmacy",
                "address": "",
                "license_number": "TEMP-" + user_id[:8]
            }).execute()
        
        # Create tokens
        access_token = create_access_token(
            data={"sub": user_id, "role": user_data.role.value}
        )
        refresh_token = create_refresh_token(
            data={"sub": user_id, "role": user_data.role.value}
        )
        
        return TokenResponse(
            access_token=access_token,
            refresh_token=refresh_token,
            user_id=user_id,
            role=user_data.role
        )
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=str(e))

@router.post("/login", response_model=TokenResponse)
async def login(credentials: UserLogin, supabase: Client = Depends(get_supabase)):
    try:
        # Get user
        user_response = supabase.table("users").select("*").eq("email", credentials.email).execute()
        
        if not user_response.data:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid credentials")
        
        user = user_response.data[0]
        
        # Verify password
        if not verify_password(credentials.password, user["password_hash"]):
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid credentials")
        
        if not user["is_active"]:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN, detail="User account is inactive")
        
        # Create tokens
        access_token = create_access_token(
            data={"sub": user["user_id"], "role": user["role"]}
        )
        refresh_token = create_refresh_token(
            data={"sub": user["user_id"], "role": user["role"]}
        )
        
        return TokenResponse(
            access_token=access_token,
            refresh_token=refresh_token,
            user_id=user["user_id"],
            role=UserRole(user["role"])
        )
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail=str(e))

@router.post("/refresh", response_model=TokenResponse)
async def refresh_token(token_data: TokenRefresh, supabase: Client = Depends(get_supabase)):
    try:
        from jose import jwt
        from config import settings
        
        payload = jwt.decode(token_data.refresh_token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
        user_id = payload.get("sub")
        role = payload.get("role")
        
        if not user_id or not role:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid refresh token")
        
        access_token = create_access_token(data={"sub": user_id, "role": role})
        new_refresh_token = create_refresh_token(data={"sub": user_id, "role": role})
        
        return TokenResponse(
            access_token=access_token,
            refresh_token=new_refresh_token,
            user_id=user_id,
            role=UserRole(role)
        )
    except Exception as e:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Invalid refresh token")

@router.post("/logout")
async def logout(user_id: str = Depends(get_current_user)):
    return {"message": "Logged out successfully"}
