resource "kubernetes_network_policy_v1" "network_policy_v1s" {
  for_each = var.network_policy_v1s


  metadata {
    annotations   = each.value.metadata.annotations
    generate_name = each.value.metadata.generate_name
    labels        = each.value.metadata.labels
    name          = each.value.metadata.name
    namespace     = each.value.metadata.namespace
  }

  spec {
    dynamic "egress" {
      for_each = each.value.spec.egress != null ? each.value.spec.egress : []
      content {
        dynamic "ports" {
          for_each = egress.value.ports != null ? egress.value.ports : []
          content {
            end_port = ports.value.end_port
            port     = ports.value.port
            protocol = ports.value.protocol
          }
        }
        dynamic "to" {
          for_each = egress.value.to != null ? egress.value.to : []
          content {
            dynamic "ip_block" {
              for_each = to.value.ip_block != null ? [to.value.ip_block] : []
              content {
                cidr   = ip_block.value.cidr
                except = ip_block.value.except
              }
            }
            dynamic "namespace_selector" {
              for_each = to.value.namespace_selector != null ? [to.value.namespace_selector] : []
              content {
                dynamic "match_expressions" {
                  for_each = namespace_selector.value.match_expressions != null ? namespace_selector.value.match_expressions : []
                  content {
                    key      = match_expressions.value.key
                    operator = match_expressions.value.operator
                    values   = match_expressions.value.values
                  }
                }
                match_labels = namespace_selector.value.match_labels
              }
            }
            dynamic "pod_selector" {
              for_each = to.value.pod_selector != null ? [to.value.pod_selector] : []
              content {
                dynamic "match_expressions" {
                  for_each = pod_selector.value.match_expressions != null ? pod_selector.value.match_expressions : []
                  content {
                    key      = match_expressions.value.key
                    operator = match_expressions.value.operator
                    values   = match_expressions.value.values
                  }
                }
                match_labels = pod_selector.value.match_labels
              }
            }
          }
        }
      }
    }
    dynamic "ingress" {
      for_each = each.value.spec.ingress != null ? each.value.spec.ingress : []
      content {
        dynamic "from" {
          for_each = ingress.value.from != null ? ingress.value.from : []
          content {
            dynamic "ip_block" {
              for_each = from.value.ip_block != null ? [from.value.ip_block] : []
              content {
                cidr   = ip_block.value.cidr
                except = ip_block.value.except
              }
            }
            dynamic "namespace_selector" {
              for_each = from.value.namespace_selector != null ? [from.value.namespace_selector] : []
              content {
                dynamic "match_expressions" {
                  for_each = namespace_selector.value.match_expressions != null ? namespace_selector.value.match_expressions : []
                  content {
                    key      = match_expressions.value.key
                    operator = match_expressions.value.operator
                    values   = match_expressions.value.values
                  }
                }
                match_labels = namespace_selector.value.match_labels
              }
            }
            dynamic "pod_selector" {
              for_each = from.value.pod_selector != null ? [from.value.pod_selector] : []
              content {
                dynamic "match_expressions" {
                  for_each = pod_selector.value.match_expressions != null ? pod_selector.value.match_expressions : []
                  content {
                    key      = match_expressions.value.key
                    operator = match_expressions.value.operator
                    values   = match_expressions.value.values
                  }
                }
                match_labels = pod_selector.value.match_labels
              }
            }
          }
        }
        dynamic "ports" {
          for_each = ingress.value.ports != null ? ingress.value.ports : []
          content {
            end_port = ports.value.end_port
            port     = ports.value.port
            protocol = ports.value.protocol
          }
        }
      }
    }
    pod_selector {
      dynamic "match_expressions" {
        for_each = each.value.spec.pod_selector.match_expressions != null ? each.value.spec.pod_selector.match_expressions : []
        content {
          key      = match_expressions.value.key
          operator = match_expressions.value.operator
          values   = match_expressions.value.values
        }
      }
      match_labels = each.value.spec.pod_selector.match_labels
    }
    policy_types = each.value.spec.policy_types
  }
}

