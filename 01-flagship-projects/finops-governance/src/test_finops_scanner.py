import unittest
from finops_scanner import evaluate_tag_compliance, detect_idle_resources, generate_finops_report

class TestFinOpsScanner(unittest.TestCase):
    def test_tag_compliance_valid(self):
        resource = {
            "id": "res-1",
            "type": "azure_vm",
            "tags": {"Environment": "prod", "Owner": "devops", "CostCenter": "CC-101"}
        }
        res = evaluate_tag_compliance(resource)
        self.assertTrue(res["compliant"])
        self.assertEqual(len(res["missing_tags"]), 0)

    def test_tag_compliance_missing(self):
        resource = {
            "id": "res-2",
            "type": "azure_vm",
            "tags": {"Environment": "prod"}
        }
        res = evaluate_tag_compliance(resource)
        self.assertFalse(res["compliant"])
        self.assertIn("Owner", res["missing_tags"])
        self.assertIn("CostCenter", res["missing_tags"])

    def test_detect_idle_disk(self):
        inventory = [
            {
                "id": "vol-123",
                "type": "aws_ebs_volume",
                "status": "available",
                "estimated_monthly_cost": 25.0
            }
        ]
        findings = detect_idle_resources(inventory)
        self.assertEqual(len(findings), 1)
        self.assertEqual(findings[0]["monthly_savings_usd"], 25.0)

    def test_detect_underutilized_vm(self):
        inventory = [
            {
                "id": "vm-prod-idle",
                "type": "azure_vm",
                "avg_cpu_percent": 2.1,
                "estimated_monthly_cost": 100.0
            }
        ]
        findings = detect_idle_resources(inventory)
        self.assertEqual(len(findings), 1)
        self.assertEqual(findings[0]["monthly_savings_usd"], 50.0)

    def test_full_report_generation(self):
        inventory = [
            {
                "id": "res-1",
                "type": "aws_elastic_ip",
                "associated_instance": None,
                "tags": {"Environment": "prod", "Owner": "ops", "CostCenter": "CC-1"}
            }
        ]
        report = generate_finops_report(inventory)
        self.assertEqual(report["summary"]["total_resources_scanned"], 1)
        self.assertEqual(report["summary"]["tagging_compliance_percentage"], 100.0)
        self.assertGreater(report["summary"]["total_monthly_waste_identified_usd"], 0)

if __name__ == "__main__":
    unittest.main()

