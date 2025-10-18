from fastapi import APIRouter, Depends, HTTPException, status
from schemas import PharmacyResponse, UserRole
from auth import get_current_user_with_role, require_role
from database import get_supabase
from supabase import Client

router = APIRouter(prefix="/api/pharmacy", tags=["pharmacy"])

@router.get("/me", response_model=PharmacyResponse)
async def get_pharmacy_profile(
    user_data: dict = Depends(require_role(UserRole.PHARMACY)),
    supabase: Client = Depends(get_supabase)
):
    pharmacy_response = supabase.table("pharmacies").select("*").eq("user_id", user_data["user_id"]).execute()
    
    if not pharmacy_response.data:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Pharmacy profile not found")
    
    return pharmacy_response.data[0]

@router.get("/prescriptions")
async def get_pending_prescriptions(
    user_data: dict = Depends(require_role(UserRole.PHARMACY)),
    supabase: Client = Depends(get_supabase)
):
    prescriptions_response = supabase.table("prescriptions").select("*").eq("status", "pending").execute()
    return prescriptions_response.data

@router.get("/inventory")
async def get_inventory(
    user_data: dict = Depends(require_role(UserRole.PHARMACY)),
    supabase: Client = Depends(get_supabase)
):
    pharmacy_response = supabase.table("pharmacies").select("*").eq("user_id", user_data["user_id"]).execute()
    pharmacy_id = pharmacy_response.data[0]["pharmacy_id"]
    
    inventory_response = supabase.table("inventory").select("*").eq("pharmacy_id", pharmacy_id).execute()
    return inventory_response.data
