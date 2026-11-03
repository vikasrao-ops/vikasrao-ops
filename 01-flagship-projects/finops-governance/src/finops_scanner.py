#!/usr/bin/env python3
"""
FinOps Cloud Resource & Cost Waste Scanner
Author: Vikas Rao (vikasrao-ops)
Analyzes multi-cloud infrastructure metadata for tagging compliance, idle waste, and rightsizing opportunities.
"""

import sys
import json
import argparse
from typing import Dict, List, Any

MANDATORY_TAGS = {"Environment", "Owner", "CostCenter"}

def evaluate_tag_compliance(resource: Dict[str, Any]) -> Dict[str, Any]:
    """Evaluates whether a cloud resource complies with required enterprise FinOps tags."""
    tags = resource.get("tags", {})
    missing_tags = [tag for tag in MANDATORY_TAGS if tag not in tags]
    return {
        "resource_id": resource.get("id", "unknown"),
        "resource_type": resource.get("type", "unknown"),
        "compliant": len(missing_tags) == 0,
        "missing_tags": missing_tags
    }

def detect_idle_resources(inventory: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    """Identifies idle resources generating wasted cloud spend."""
    idle_findings = []
    for res in inventory:
        res_type = res.get("type")
        res_id = res.get("id")
        
        # 1. Unattached storage disks
        if res_type in ["azure_managed_disk", "aws_ebs_volume"]:
            if res.get("status") in ["unattached", "available"] or not res.get("attached_to"):
                monthly_cost = res.get("estimated_monthly_cost", 20.0)
                idle_findings.append({
                    "resource_id": res_id,
                    "type": res_type,
                    "reason": "Unattached persistent storage disk",
                    "monthly_savings_usd": monthly_cost
                })

        # 2. Unassociated Elastic / Public IPs
        elif res_type in ["aws_elastic_ip", "azure_public_ip"]:
            if not res.get("associated_instance"):
                idle_findings.append({
                    "resource_id": res_id,
                    "type": res_type,
                    "reason": "Unassociated idle Public IP",
                    "monthly_savings_usd": 3.65
                })

        # 3. Underutilized compute instances (Rightsizing target)
        elif res_type in ["azure_vm", "aws_ec2"]:
            avg_cpu = res.get("avg_cpu_percent", 50.0)
            if avg_cpu < 5.0:
                current_cost = res.get("estimated_monthly_cost", 80.0)
                potential_savings = current_cost * 0.5  # Downsizing to half-size instance
                idle_findings.append({
                    "resource_id": res_id,
                    "type": res_type,
                    "reason": f"Severely underutilized compute (Avg CPU {avg_cpu}%) - Recommend 50% downsize",
                    "monthly_savings_usd": potential_savings
                })

    return idle_findings

def generate_finops_report(inventory_data: List[Dict[str, Any]]) -> Dict[str, Any]:
    """Generates an executive summary of cost optimization opportunities."""
    tagging_results = [evaluate_tag_compliance(r) for r in inventory_data]
    idle_results = detect_idle_resources(inventory_data)

    total_resources = len(inventory_data)
    non_compliant_count = sum(1 for r in tagging_results if not r["compliant"])
    total_monthly_waste = sum(f["monthly_savings_usd"] for f in idle_results)

    compliance_percentage = ((total_resources - non_compliant_count) / total_resources * 100) if total_resources > 0 else 100.0

    return {
        "summary": {
            "total_resources_scanned": total_resources,
            "tagging_compliance_percentage": round(compliance_percentage, 1),
            "total_monthly_waste_identified_usd": round(total_monthly_waste, 2),
            "annualized_projected_savings_usd": round(total_monthly_waste * 12, 2)
        },
        "tagging_violations": [r for r in tagging_results if not r["compliant"]],
        "cost_optimization_findings": idle_results
    }

def main():
    parser = argparse.ArgumentParser(description="FinOps Cloud Resource & Cost Waste Scanner")
    parser.add_argument("--inventory", required=True, help="Path to input JSON inventory file")
    parser.add_argument("--output", help="Path to write JSON report output")
    args = parser.parse_args()

    with open(args.inventory, "r") as f:
        inventory = json.load(f)

    report = generate_finops_report(inventory)

    output_json = json.dumps(report, indent=2)
    if args.output:
        with open(args.output, "w") as f:
            f.write(output_json)
        print(f"Report written to {args.output}")
    else:
        print(output_json)

if __name__ == "__main__":
    main()

