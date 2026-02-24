# Dashboard en Datadog para métricas clave de la infraestructura AWS

resource "datadog_dashboard" "aws_infrastructure" {
  title       = "AWS Infrastructure - LTI Project"
  description = "Métricas de EC2, red y sistema para backend y frontend"
  layout_type = "ordered"

  widget {
    timeseries_definition {
      title = "CPU Utilization (EC2)"
      request {
        q = "avg:aws.ec2.cpuutilization{*} by {instance-id}"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Network In"
      request {
        q = "avg:aws.ec2.network_in{*} by {instance-id}"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Network Out"
      request {
        q = "avg:aws.ec2.network_out{*} by {instance-id}"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Disk Read/Write"
      request {
        q = "avg:aws.ec2.disk_read_ops{*} by {instance-id}"
      }
      request {
        q = "avg:aws.ec2.disk_write_ops{*} by {instance-id}"
      }
    }
  }

  widget {
    query_value_definition {
      title = "Status Check Failed (Instance)"
      request {
        q          = "sum:aws.ec2.status_check_failed_instance{*}.as_count()"
        aggregator = "sum"
      }
    }
  }

  widget {
    timeseries_definition {
      title = "Agent host metrics (Datadog Agent)"
      request {
        q = "avg:system.cpu.user{*} by {host}"
      }
    }
  }
}
