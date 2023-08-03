resource "shoreline_notebook" "cassandra_node_unavailability" {
  name       = "cassandra_node_unavailability"
  data       = file("${path.module}/data/cassandra_node_unavailability.json")
  depends_on = [shoreline_action.invoke_cassandra_reinstall,shoreline_action.invoke_restore_backup_cassandra,shoreline_action.invoke_reboot_node,shoreline_action.invoke_backup_restore_cassandra]
}

resource "shoreline_file" "cassandra_reinstall" {
  name             = "cassandra_reinstall"
  input_file       = "${path.module}/data/cassandra_reinstall.sh"
  md5              = filemd5("${path.module}/data/cassandra_reinstall.sh")
  description      = "Attempt to repair the Cassandra installation or reinstall it if necessary."
  destination_path = "/agent/scripts/cassandra_reinstall.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "restore_backup_cassandra" {
  name             = "restore_backup_cassandra"
  input_file       = "${path.module}/data/restore_backup_cassandra.sh"
  md5              = filemd5("${path.module}/data/restore_backup_cassandra.sh")
  description      = "Restore from a recent backup if data loss or corruption has occurred."
  destination_path = "/agent/scripts/restore_backup_cassandra.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "reboot_node" {
  name             = "reboot_node"
  input_file       = "${path.module}/data/reboot_node.sh"
  md5              = filemd5("${path.module}/data/reboot_node.sh")
  description      = "Reboot the node to attempt to clear any software issues that may be causing the unavailability."
  destination_path = "/agent/scripts/reboot_node.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "backup_restore_cassandra" {
  name             = "backup_restore_cassandra"
  input_file       = "${path.module}/data/backup_restore_cassandra.sh"
  md5              = filemd5("${path.module}/data/backup_restore_cassandra.sh")
  description      = "Restore from a cassandra backup if data loss or corruption has occurred."
  destination_path = "/agent/scripts/backup_restore_cassandra.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_cassandra_reinstall" {
  name        = "invoke_cassandra_reinstall"
  description = "Attempt to repair the Cassandra installation or reinstall it if necessary."
  command     = "`chmod +x /agent/scripts/cassandra_reinstall.sh && /agent/scripts/cassandra_reinstall.sh`"
  params      = []
  file_deps   = ["cassandra_reinstall"]
  enabled     = true
  depends_on  = [shoreline_file.cassandra_reinstall]
}

resource "shoreline_action" "invoke_restore_backup_cassandra" {
  name        = "invoke_restore_backup_cassandra"
  description = "Restore from a recent backup if data loss or corruption has occurred."
  command     = "`chmod +x /agent/scripts/restore_backup_cassandra.sh && /agent/scripts/restore_backup_cassandra.sh`"
  params      = ["RESTORE_DIRECTORY","BACKUP_FILE_NAME"]
  file_deps   = ["restore_backup_cassandra"]
  enabled     = true
  depends_on  = [shoreline_file.restore_backup_cassandra]
}

resource "shoreline_action" "invoke_reboot_node" {
  name        = "invoke_reboot_node"
  description = "Reboot the node to attempt to clear any software issues that may be causing the unavailability."
  command     = "`chmod +x /agent/scripts/reboot_node.sh && /agent/scripts/reboot_node.sh`"
  params      = []
  file_deps   = ["reboot_node"]
  enabled     = true
  depends_on  = [shoreline_file.reboot_node]
}

resource "shoreline_action" "invoke_backup_restore_cassandra" {
  name        = "invoke_backup_restore_cassandra"
  description = "Restore from a cassandra backup if data loss or corruption has occurred."
  command     = "`chmod +x /agent/scripts/backup_restore_cassandra.sh && /agent/scripts/backup_restore_cassandra.sh`"
  params      = ["BACKUP_LOCATION","CASSANDRA_DATA_LOCATION"]
  file_deps   = ["backup_restore_cassandra"]
  enabled     = true
  depends_on  = [shoreline_file.backup_restore_cassandra]
}

