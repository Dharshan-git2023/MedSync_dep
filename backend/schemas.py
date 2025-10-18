from pydantic import BaseModel, EmailStr
from typing import Optional, List
from datetime import datetime
from enum import Enum

class UserRole(str, Enum):
    ADMIN = "admin"
    DOCTOR = "doctor"
    PATIENT = "patient"
    PHARMACY = "pharmacy"

# Authentication Schemas
class UserRegister(BaseModel):
    email: EmailStr
    password: str
    full_name: str
    phone_number: Optional[str] = None
    role: UserRole

class UserLogin(BaseModel):
    email: EmailStr
    password: str

class TokenResponse(BaseModel):
    access_token: str
    refresh_token: str
    token_type: str = "bearer"
    user_id: str
    role: UserRole

class TokenRefresh(BaseModel):
    refresh_token: str

# User Schemas
class UserResponse(BaseModel):
    user_id: str
    email: str
    full_name: str
    phone_number: Optional[str]
    role: UserRole
    is_active: bool
    created_at: datetime

# Doctor Schemas
class DoctorCreate(BaseModel):
    specialization: str
    license_number: str
    hospital_id: str

class DoctorResponse(BaseModel):
    doctor_id: str
    user_id: str
    specialization: str
    license_number: str
    hospital_id: str

# Patient Schemas
class PatientCreate(BaseModel):
    date_of_birth: Optional[str] = None
    gender: Optional[str] = None
    blood_group: Optional[str] = None
    address: Optional[str] = None
    emergency_contact: Optional[str] = None

class PatientResponse(BaseModel):
    patient_id: str
    user_id: str
    date_of_birth: Optional[str]
    gender: Optional[str]
    blood_group: Optional[str]
    address: Optional[str]
    emergency_contact: Optional[str]

# Hospital Schemas
class HospitalCreate(BaseModel):
    hospital_name: str
    address: str
    contact_number: str
    license_number: str

class HospitalResponse(BaseModel):
    hospital_id: str
    hospital_name: str
    address: str
    contact_number: str
    license_number: str

# Pharmacy Schemas
class PharmacyCreate(BaseModel):
    pharmacy_name: str
    address: str
    license_number: str
    delivery_available: bool = False
    delivery_radius_km: Optional[float] = None
    delivery_fee: Optional[float] = None
    min_order_for_free_delivery: Optional[float] = None

class PharmacyResponse(BaseModel):
    pharmacy_id: str
    user_id: str
    pharmacy_name: str
    address: str
    license_number: str
    delivery_available: bool

# Prescription Schemas
class MedicationItem(BaseModel):
    medication_name: str
    dosage: str
    frequency: str
    duration_days: int
    quantity: int

class PrescriptionCreate(BaseModel):
    patient_id: str
    medications: List[MedicationItem]
    diagnosis: str
    symptoms: str
    notes: Optional[str] = None

class PrescriptionResponse(BaseModel):
    prescription_id: str
    patient_id: str
    doctor_id: str
    prescription_date: str
    status: str
    medications: List[dict]
    total_cost: Optional[float]
