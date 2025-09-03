# Terraform Security POC with AI

This repo demonstrates how to use **AI + security scanners** to review Terraform PRs.

## 🚀 Features

- Runs **Checkov** and **tfsec** on every PR
- AI summarizes vulnerabilities in plain English
- PR comment includes risks and fixes

## 🛠 Setup

1. Fork this repo
2. Add `OPENAI_API_KEY` in **GitHub → Settings → Secrets → Actions**
3. Create a new PR with Terraform changes
4. The workflow will:
   - Run Checkov + tfsec
   - Call AI to summarize results
   - Post summary as PR comment

## 🧪 Test

Try editing `main.tf`:

- Make a bucket `acl = "public-read"` → AI should flag it
- Add `cidr_blocks = ["0.0.0.0/0"]` in security group → AI should flag it
