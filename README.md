# MedSync - Medical Data Monitoring and Resource Coordination System

A comprehensive healthcare platform built with Vue3, FastAPI, and Supabase for unified patient records, e-prescriptions, and resource coordination.

## 🏥 System Overview

MedSync is a full-stack healthcare management system designed to streamline operations across hospitals, clinics, pharmacies, and patient care. The platform provides role-based dashboards for administrators, doctors, patients, and pharmacy staff.

### Key Features

- **Unified Patient Records**: Centralized medical history and health data
- **E-Prescriptions**: Digital prescription management with verification
- **Real-time Resource Coordination**: Hospital-pharmacy collaboration
- **AI Health Assistant**: Intelligent chatbot for patient support
- **Delivery Tracking**: Real-time medication delivery monitoring
- **Analytics Dashboard**: System-wide insights and reporting
- **FHIR Compliant**: Healthcare data interoperability standards

## 🏗️ Architecture

### Tech Stack

- **Frontend**: Vue3 + Vite + Tailwind CSS
- **Backend**: FastAPI + Python
- **Database**: Supabase (PostgreSQL)
- **Authentication**: JWT with refresh tokens
- **Real-time**: WebSocket support (optional)

### Project Structure

\`\`\`
healthcare-system/
├── frontend/                 # Vue3 application
│   ├── src/
│   │   ├── views/           # Page components
│   │   │   ├── admin/       # Admin dashboards
│   │   │   ├── doctor/      # Doctor dashboards
│   │   │   ├── patient/     # Patient dashboards
│   │   │   ├── pharmacy/    # Pharmacy dashboards
│   │   │   └── auth/        # Authentication pages
│   │   ├── components/      # Reusable components
│   │   ├── stores/          # Pinia state management
│   │   ├── router/          # Vue Router configuration
│   │   ├── api/             # API client setup
│   │   └── style.css        # Global styles
│   ├── package.json
│   ├── vite.config.js
│   └── tailwind.config.js
│
├── backend/                  # FastAPI application
│   ├── routes/              # API endpoints
│   │   ├── auth.py          # Authentication routes
│   │   ├── users.py         # User management
│   │   ├── doctors.py       # Doctor operations
│   │   ├── patients.py      # Patient operations
│   │   └── pharmacy.py      # Pharmacy operations
│   ├── auth.py              # JWT authentication
│   ├── database.py          # Database connection
│   ├── schemas.py           # Pydantic models
│   ├── config.py            # Configuration
│   ├── main.py              # FastAPI app entry
│   ├── requirements.txt     # Python dependencies
│   └── .env.example         # Environment template
│
└── database/                # SQL migration scripts
    ├── 01-auth-tables.sql
    ├── 02-hospital-tables.sql
    ├── 03-doctor-tables.sql
    ├── 04-patient-tables.sql
    ├── 05-pharmacy-tables.sql
    ├── 06-prescription-tables.sql
    ├── 07-appointment-tables.sql
    ├── 08-delivery-tables.sql
    ├── 09-collaboration-tables.sql
    ├── 10-ai-tables.sql
    └── 11-analytics-tables.sql
\`\`\`

## 🚀 Getting Started

### Prerequisites

- Node.js 16+ and npm
- Python 3.9+
- PostgreSQL (via Supabase)
- Git

### Local Development Setup

#### 1. Clone the Repository

\`\`\`bash
git clone https://github.com/yourusername/healthcare-system.git
cd healthcare-system
\`\`\`

#### 2. Database Setup

1. Create a Supabase project at https://supabase.com
2. Get your database credentials
3. Run SQL migration scripts in order:
   - Go to Supabase Dashboard → SQL Editor
   - Copy and run each SQL file from `database/` folder in order (01 through 11)

#### 3. Backend Setup

\`\`\`bash
cd backend

# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Create .env file
cp .env.example .env

# Update .env with your Supabase credentials
# SUPABASE_URL=your_supabase_url
# SUPABASE_KEY=your_supabase_key
# JWT_SECRET=your_jwt_secret_key

# Run FastAPI server
python -m uvicorn main:app --reload
\`\`\`

Backend will be available at `http://localhost:8000`

#### 4. Frontend Setup

\`\`\`bash
cd frontend

# Install dependencies
npm install

# Create .env file
echo "VITE_API_URL=http://localhost:8000" > .env

# Run development server
npm run dev
\`\`\`

Frontend will be available at `http://localhost:5173`

## 📊 User Roles & Dashboards

### 1. Admin Dashboard
- System statistics and analytics
- User management (doctors, patients, pharmacies)
- Hospital network management
- Resource monitoring
- Audit logs

**Access**: `/admin/dashboard`

### 2. Doctor Dashboard
- Patient list and management
- Medical records and history
- Prescription creation and management
- Appointment scheduling
- AI medical assistant

**Access**: `/doctor/dashboard`

### 3. Patient Dashboard
- Personal health records
- Active prescriptions
- Medication ordering
- Appointment management
- Health timeline
- AI health assistant

**Access**: `/patient/dashboard`

### 4. Pharmacy Dashboard
- Prescription queue management
- Inventory management
- Delivery tracking
- Hospital collaboration
- Low stock alerts
- Order analytics

**Access**: `/pharmacy/dashboard`

## 🔐 Authentication

### Login Credentials (Demo)

\`\`\`
Admin:
Email: admin@medsync.com
Password: admin123

Doctor:
Email: doctor@medsync.com
Password: doctor123

Patient:
Email: patient@medsync.com
Password: patient123

Pharmacy:
Email: pharmacy@medsync.com
Password: pharmacy123
\`\`\`

### JWT Token Flow

1. User logs in with email/password
2. Backend validates credentials and returns JWT token
3. Token stored in localStorage
4. Token included in all API requests
5. Token auto-refreshed before expiration

## 📡 API Endpoints

### Authentication
- `POST /api/auth/register` - User registration
- `POST /api/auth/login` - User login
- `POST /api/auth/refresh` - Refresh JWT token
- `POST /api/auth/logout` - User logout

### Users
- `GET /api/users/me` - Get current user
- `GET /api/users` - List users (admin only)
- `PUT /api/users/{user_id}` - Update user
- `DELETE /api/users/{user_id}` - Delete user

### Doctors
- `GET /api/doctors` - List doctors
- `GET /api/doctors/{doctor_id}` - Get doctor details
- `POST /api/doctors` - Create doctor
- `GET /api/doctors/{doctor_id}/patients` - Get doctor's patients

### Patients
- `GET /api/patients` - List patients
- `GET /api/patients/{patient_id}` - Get patient details
- `POST /api/patients` - Create patient
- `GET /api/patients/{patient_id}/records` - Get medical records
- `GET /api/patients/{patient_id}/prescriptions` - Get prescriptions

### Pharmacy
- `GET /api/pharmacy/prescriptions` - Get prescription queue
- `GET /api/pharmacy/inventory` - Get inventory
- `PUT /api/pharmacy/inventory/{item_id}` - Update inventory
- `GET /api/pharmacy/orders` - Get orders

## 🎨 Design System

### Color Palette

- **Primary Blue**: `#1976D2` - Main actions and highlights
- **Secondary Teal**: `#00897B` - Secondary actions
- **Success Green**: `#43A047` - Positive states
- **Warning Orange**: `#FB8C00` - Alerts and warnings
- **Danger Red**: `#E53935` - Critical alerts
- **Background**: `#F5F7FA` - Light backgrounds
- **Text**: `#263238` - Dark text

### Typography

- **Headings**: Poppins (600 weight)
- **Body**: Inter (400 weight)
- **Monospace**: Fira Code (for code blocks)

### Components

All components use Tailwind CSS with custom design tokens. Key components:

- Cards with shadows and rounded corners
- Gradient backgrounds for visual hierarchy
- Smooth transitions and hover effects
- Responsive grid layouts
- Form inputs with validation states
- Status badges and indicators

## 📱 Responsive Design

The application is fully responsive with breakpoints:

- **Mobile**: < 640px
- **Tablet**: 640px - 1024px
- **Desktop**: > 1024px

## 🔄 Data Flow

### Patient Registration Flow

1. User fills registration form
2. Frontend validates input
3. POST request to `/api/auth/register`
4. Backend hashes password and creates user
5. Patient record created in database
6. JWT token returned
7. User redirected to dashboard

### Prescription Flow

1. Doctor creates prescription in dashboard
2. Prescription data sent to backend
3. Backend validates and stores in database
4. Prescription marked as "pending"
5. Pharmacy receives notification
6. Pharmacy processes and marks as "filled"
7. Patient can order medications
8. Order created and delivery initiated

## 🧪 Testing

### Manual Testing Checklist

- [ ] User registration and login
- [ ] Role-based access control
- [ ] Patient dashboard displays correctly
- [ ] Doctor can create prescriptions
- [ ] Pharmacy can process prescriptions
- [ ] Admin can manage users
- [ ] Responsive design on mobile
- [ ] API error handling
- [ ] Token refresh functionality

### API Testing with cURL

\`\`\`bash
# Login
curl -X POST http://localhost:8000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"patient@medsync.com","password":"patient123"}'

# Get current user
curl -X GET http://localhost:8000/api/users/me \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"

# Get patient records
curl -X GET http://localhost:8000/api/patients/PATIENT_ID/records \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
\`\`\`

## 🚢 Production Deployment

### Frontend Deployment (Vercel)

\`\`\`bash
# Build for production
npm run build

# Deploy to Vercel
vercel deploy --prod
\`\`\`

### Backend Deployment (Heroku/Railway)

\`\`\`bash
# Create Procfile
echo "web: uvicorn main:app --host 0.0.0.0 --port $PORT" > Procfile

# Deploy to Heroku
heroku create your-app-name
git push heroku main
\`\`\`

### Environment Variables

Set these in your production environment:

\`\`\`
SUPABASE_URL=your_production_supabase_url
SUPABASE_KEY=your_production_supabase_key
JWT_SECRET=your_production_jwt_secret
CORS_ORIGINS=https://yourdomain.com
DATABASE_URL=your_production_database_url
\`\`\`

## 📚 Database Schema

### Key Tables

- **users**: User accounts with roles
- **doctors**: Doctor profiles linked to hospitals
- **patients**: Patient profiles with health info
- **hospitals**: Hospital information
- **pharmacies**: Pharmacy details and inventory
- **prescriptions**: E-prescriptions with medications
- **medical_records**: Patient visit history
- **appointments**: Doctor-patient appointments
- **orders**: Medication orders with delivery
- **deliveries**: Delivery tracking information

See `database/` folder for complete schema definitions.

## 🔒 Security Features

- JWT authentication with refresh tokens
- Password hashing with bcrypt
- Role-based access control (RBAC)
- SQL injection prevention with parameterized queries
- CORS configuration
- Input validation and sanitization
- Secure session management
- HTTPS enforcement in production

## 🐛 Troubleshooting

### Common Issues

**Frontend won't connect to backend**
- Check VITE_API_URL in .env
- Ensure backend is running on port 8000
- Check CORS settings in FastAPI

**Database connection error**
- Verify Supabase credentials in .env
- Check database URL format
- Ensure Supabase project is active

**JWT token expired**
- Token auto-refreshes before expiration
- Clear localStorage and login again if issues persist

**Port already in use**
- Frontend: `npm run dev -- --port 3000`
- Backend: `uvicorn main:app --port 8001`

## 📖 Documentation

- [Vue3 Documentation](https://vuejs.org/)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)
- [Supabase Documentation](https://supabase.com/docs)
- [Tailwind CSS Documentation](https://tailwindcss.com/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see LICENSE file for details.

## 👥 Support

For support, email support@medsync.com or open an issue on GitHub.

## 🎯 Roadmap

- [ ] Mobile app (React Native)
- [ ] Video consultation feature
- [ ] Advanced analytics and reporting
- [ ] Integration with insurance providers
- [ ] Telemedicine capabilities
- [ ] Blockchain for prescription verification
- [ ] Multi-language support
- [ ] Advanced AI diagnostics

## 🙏 Acknowledgments

- Healthcare data standards (FHIR)
- Open source community
- Contributors and testers

---

**Version**: 1.0.0  
**Last Updated**: October 2025  
**Status**: Production Ready
