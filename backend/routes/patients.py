from fastapi import APIRouter, Depends, HTTPException, status
from schemas import PatientResponse, UserRole
from auth import get_current_user_with_role, require_role
from database import get_supabase
from supabase import Client

router = APIRouter(prefix="/api/patients", tags=["patients"])

@router.get("/me", response_model=PatientResponse)
async def get_patient_profile(
    user_data: dict = Depends(require_role(UserRole.PATIENT)),
    supabase: Client = Depends(get_supabase)
):
    patient_response = supabase.table("patients").select("*").eq("user_id", user_data["user_id"]).execute()
    
    if not patient_response.data:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Patient profile not found")
    
    return patient_response.data[0]

@router.get("/medical-history")
async def get_medical_history(
    user_data: dict = Depends(require_role(UserRole.PATIENT)),
    supabase: Client = Depends(get_supabase)
):
    patient_response = supabase.table("patients").select("*").eq("user_id", user_data["user_id"]).execute()
    patient_id = patient_response.data[0]["patient_id"]
    
    records_response = supabase.table("medical_records").select("*").eq("patient_id", patient_id).order("visit_date", desc=True).execute()
    return records_response.data

@router.get("/prescriptions")
async def get_patient_prescriptions(
    user_data: dict = Depends(require_role(UserRole.PATIENT)),
    supabase: Client = Depends(get_supabase)
):
    patient_response = supabase.table("patients").select("*").eq("user_id", user_data["user_id"]).execute()
    patient_id = patient_response.data[0]["patient_id"]
    
    prescriptions_response = supabase.table("prescriptions").select("*").eq("patient_id", patient_id).order("prescription_date", desc=True).execute()
    return prescriptions_response.data
