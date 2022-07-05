# github-cli

## Billing API

### Get GitHub Actions billing for polymathrobotics
```
gh auth login --with-token < ~/.secrets/github/gh-admin-org-read-token
gh api \
  -H "Accept: application/vnd.github+json" \
  /orgs/polymathrobotics/settings/billing/actions
{
  "total_minutes_used": 2192,
  "total_paid_minutes_used": 0,
  "included_minutes": 3000,
  "minutes_used_breakdown": {
    "UBUNTU": 2192,
    "MACOS": 0,
    "WINDOWS": 0,
    "total": 2192
  }
}
gh auth logout
```

### Get GitHub Packages billing for an organization
```
gh api \
  -H "Accept: application/vnd.github+json" \
  /orgs/polymathrobotics/settings/billing/packages
{
  "days_left_in_billing_cycle": 9,
  "estimated_paid_storage_for_month": 0,
  "estimated_storage_for_month": 0
}  
```

### Get shared storage billing for an organization
```
gh api \
  -H "Accept: application/vnd.github+json" \
  /orgs/polymathrobotics/settings/billing/shared-storage
{
  "total_gigabytes_bandwidth_used": 0,
  "total_paid_gigabytes_bandwidth_used": 0,
  "included_gigabytes_bandwidth": 10
}  
```
