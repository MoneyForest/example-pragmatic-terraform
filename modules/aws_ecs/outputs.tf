output "iam_role_arn" {
  value = module.ecs_task_execution_role.iam_role_arn
}

output "iam_role_name" {
  value = module.ecs_task_execution_role.iam_role_name
}