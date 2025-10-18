#!/usr/bin/env python3
"""
Simple helper to verify a plaintext password against a bcrypt hash using passlib.

Usage (PowerShell):
  & "venv\Scripts\python.exe" scripts\verify_password.py patient123 '$2b$12$...'

The hash argument should be quoted with single quotes in PowerShell to avoid $-expansion.
"""
import sys
from passlib.context import CryptContext

def main():
    if len(sys.argv) != 3:
        print("Usage: verify_password.py <plaintext> <bcrypt-hash>")
        sys.exit(2)

    plaintext = sys.argv[1]
    bcrypt_hash = sys.argv[2]

    pwd = CryptContext(schemes=["bcrypt"], deprecated="auto")
    try:
        ok = pwd.verify(plaintext, bcrypt_hash)
        print("verify:", ok)
        sys.exit(0 if ok else 1)
    except Exception as e:
        print("error:", type(e).__name__, str(e))
        sys.exit(3)

if __name__ == '__main__':
    main()
