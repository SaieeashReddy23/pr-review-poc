import json
import sys
import openai

openai.api_key = os.getenv("OPENAI_API_KEY")

report_file = sys.argv[1]

with open(report_file, "r") as f:
    report = f.read()

prompt = f"""
You are a cloud security reviewer. Analyze this Terraform scan report.
- Summarize key vulnerabilities in simple language.
- Mark risks as Critical / High / Medium / Low.
- Suggest Terraform code changes to fix them.
- If everything looks safe, respond with ✅ 'No major security risks found.'

Report:
{report}
"""

response = openai.ChatCompletion.create(
    model="gpt-4o-mini",
    messages=[{"role": "user", "content": prompt}]
)

print(response["choices"][0]["message"]["content"])
