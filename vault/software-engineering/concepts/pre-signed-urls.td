---
_type: SoftEngConcept
_label: 'Pre-signed URLs'
journey: fref("software-engineering/index.td")
status: 'learning'
tags:
  - 'architecture'
---

A pattern where the server generates a temporary, authenticated URL that allows a client to upload or download directly from blob storage (S3, Azure Blob, etc.) without going through the backend.

## Upload Flow

1. Client requests upload from the backend.
2. Backend stores metadata in DB and generates a pre-signed URL for the blob store.
3. Client uploads file content directly to blob storage using that URL.

The backend never touches the file bytes. This reduces memory pressure and scales better.

## Download Flow

The same pattern in reverse. The backend generates a pre-signed download URL. The client fetches directly from blob storage (often via CDN).

## Error Handling

This is a distributed transaction without a coordinator:

- DB fails storing metadata: Clean failure. No URL generated.
- Metadata stored, but upload fails: Orphaned metadata. Mitigate with a `status: 'pending'` field and a background cleanup job.
- Upload succeeds, but confirmation fails: File exists but metadata is incomplete. Blob storage lifecycle rules can auto-delete unconfirmed objects.

## Where It Appears

- Supabase Storage uses pre-signed URLs for S3 uploads.
- The GitHub Contents API's `download_url` is a pre-signed URL (no auth needed, expires after use).
