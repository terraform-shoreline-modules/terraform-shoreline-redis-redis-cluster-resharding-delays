resource "shoreline_notebook" "redis_cluster_resharding_delays" {
  name       = "redis_cluster_resharding_delays"
  data       = file("${path.module}/data/redis_cluster_resharding_delays.json")
  depends_on = [shoreline_action.invoke_redis_resharding]
}

resource "shoreline_file" "redis_resharding" {
  name             = "redis_resharding"
  input_file       = "${path.module}/data/redis_resharding.sh"
  md5              = filemd5("${path.module}/data/redis_resharding.sh")
  description      = "Optimize the resharding algorithm: Redis provides various resharding algorithms that can be used to optimize the resharding process. Choosing the right algorithm based on the cluster's specific needs may help to improve performance."
  destination_path = "/tmp/redis_resharding.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_redis_resharding" {
  name        = "invoke_redis_resharding"
  description = "Optimize the resharding algorithm: Redis provides various resharding algorithms that can be used to optimize the resharding process. Choosing the right algorithm based on the cluster's specific needs may help to improve performance."
  command     = "`chmod +x /tmp/redis_resharding.sh && /tmp/redis_resharding.sh`"
  params      = ["PATH_TO_REDIS_CONFIG_FILE"]
  file_deps   = ["redis_resharding"]
  enabled     = true
  depends_on  = [shoreline_file.redis_resharding]
}

