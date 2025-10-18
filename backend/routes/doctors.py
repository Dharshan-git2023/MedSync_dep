from fastapi import APIRouter, Depends, HTTPException, status
from schemas import DoctorResponse, UserRole
from auth import get_current_user_with_role, require_role
from database import get_supabase
from supabase import Client

router = APIRouter(prefix="/api/doctors", tags=["doctors"])

@router.get("/me", response_model=DoctorResponse)
async def get_doctor_profile(
    user_data: dict = Depends(require_role(UserRole.DOCTOR)),
    supabase: Client = Depends(get_supabase)
):
    doctor_response = supabase.table("doctors").select("*").eq("user_id", user_data["user_id"]).execute()
    
    if not doctor_response.data:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Doctor profile not found")
    
    return doctor_response.data[0]

@router.get("/patients")
async def get_doctor_patients(
    user_data: dict = Depends(require_role(UserRole.DOCTOR)),
    supabase: Client = Depends(get_supabase)
):
    doctor_response = supabase.table("doctors").select("*").eq("user_id", user_data["user_id"]).execute()
    doctor_id = doctor_response.data[0]["doctor_id"]
    
    patients_response = supabase.table("patients").select("*").eq("assigned_doctor_id", doctor_id).execute()
    return patients_response.data

@router.get("/patients/{patient_id}/records")
async def get_patient_records(
    patient_id: str,
    user_data: dict = Depends(require_role(UserRole.DOCTOR)),
    supabase: Client = Depends(get_supabase)
):
    records_response = supabase.table("medical_records").select("*").eq("patient_id", patient_id).execute()
    return records_response.data
