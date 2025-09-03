# .github/scripts/ai_review.py
import os
import sys
import json
from openai import OpenAI

# Get API key from env
api_key = os.getenv("OPENAI_API_KEY")
if not api_key:
    print("❌ OPENAI_API_KEY is missing. Please set it in GitHub secrets.")
    sys.exit(1)

client = OpenAI(api_key=api_key)

# Load the Checkov report
report_path = sys.argv[1]
with open(report_path, "r") as f:
    report = json.load(f)

# Prepare a prompt for the AI
prompt = f"""
You are a security reviewer. Analyze the following Checkov Terraform scan report
and summarize key findings. Highlight **High** and **Critical** issues first.

Report JSON:
{json.dumps(report)[:5000]}  # keep prompt small, truncate if huge
"""

# Call OpenAI (GPT-4o-mini for cheaper, fast review)
response = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[{"role": "user", "content": prompt}],
)

print(response.choices[0].message.content)
