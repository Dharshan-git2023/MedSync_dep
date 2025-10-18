from fastapi import APIRouter, Depends, HTTPException, status
from schemas import UserResponse, UserRole
from auth import get_current_user_with_role, require_role
from database import get_supabase
from supabase import Client

router = APIRouter(prefix="/api/users", tags=["users"])

@router.get("/me", response_model=UserResponse)
async def get_current_user_info(
    user_data: dict = Depends(get_current_user_with_role),
    supabase: Client = Depends(get_supabase)
):
    user_response = supabase.table("users").select("*").eq("user_id", user_data["user_id"]).execute()
    
    if not user_response.data:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="User not found")
    
    user = user_response.data[0]
    return UserResponse(**user)

@router.get("/admin/users")
async def get_all_users(
    user_data: dict = Depends(require_role(UserRole.ADMIN)),
    supabase: Client = Depends(get_supabase)
):
    users_response = supabase.table("users").select("*").execute()
    return users_response.data

@router.put("/admin/users/{user_id}/status")
async def update_user_status(
    user_id: str,
    is_active: bool,
    user_data: dict = Depends(require_role(UserRole.ADMIN)),
    supabase: Client = Depends(get_supabase)
):
    supabase.table("users").update({"is_active": is_active}).eq("user_id", user_id).execute()
    return {"message": "User status updated"}
