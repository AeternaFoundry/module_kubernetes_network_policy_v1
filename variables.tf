variable "network_policy_v1s" {
  description = <<EOT
Map of network_policy_v1s, attributes below
Required:
    - metadata (block):
        - annotations (optional)
        - generate_name (optional)
        - labels (optional)
        - name (optional)
        - namespace (optional)
    - spec (block):
        - egress (optional, block):
            - ports (optional, block):
                - end_port (optional)
                - port (optional)
                - protocol (optional)
            - to (optional, block):
                - ip_block (optional, block):
                    - cidr (optional)
                    - except (optional)
                - namespace_selector (optional, block):
                    - match_expressions (optional, block):
                        - key (optional)
                        - operator (optional)
                        - values (optional)
                    - match_labels (optional)
                - pod_selector (optional, block):
                    - match_expressions (optional, block):
                        - key (optional)
                        - operator (optional)
                        - values (optional)
                    - match_labels (optional)
        - ingress (optional, block):
            - from (optional, block):
                - ip_block (optional, block):
                    - cidr (optional)
                    - except (optional)
                - namespace_selector (optional, block):
                    - match_expressions (optional, block):
                        - key (optional)
                        - operator (optional)
                        - values (optional)
                    - match_labels (optional)
                - pod_selector (optional, block):
                    - match_expressions (optional, block):
                        - key (optional)
                        - operator (optional)
                        - values (optional)
                    - match_labels (optional)
            - ports (optional, block):
                - end_port (optional)
                - port (optional)
                - protocol (optional)
        - pod_selector (required, block):
            - match_expressions (optional, block):
                - key (optional)
                - operator (optional)
                - values (optional)
            - match_labels (optional)
        - policy_types (required)
EOT

  type = map(object({
    metadata = object({
      annotations   = optional(map(string))
      generate_name = optional(string)
      labels        = optional(map(string))
      name          = optional(string)
      namespace     = optional(string)
    })
    spec = object({
      egress = optional(list(object({
        ports = optional(list(object({
          end_port = optional(number)
          port     = optional(string)
          protocol = optional(string)
        })))
        to = optional(list(object({
          ip_block = optional(object({
            cidr   = optional(string)
            except = optional(list(string))
          }))
          namespace_selector = optional(object({
            match_expressions = optional(list(object({
              key      = optional(string)
              operator = optional(string)
              values   = optional(set(string))
            })))
            match_labels = optional(map(string))
          }))
          pod_selector = optional(object({
            match_expressions = optional(list(object({
              key      = optional(string)
              operator = optional(string)
              values   = optional(set(string))
            })))
            match_labels = optional(map(string))
          }))
        })))
      })))
      ingress = optional(list(object({
        from = optional(list(object({
          ip_block = optional(object({
            cidr   = optional(string)
            except = optional(list(string))
          }))
          namespace_selector = optional(object({
            match_expressions = optional(list(object({
              key      = optional(string)
              operator = optional(string)
              values   = optional(set(string))
            })))
            match_labels = optional(map(string))
          }))
          pod_selector = optional(object({
            match_expressions = optional(list(object({
              key      = optional(string)
              operator = optional(string)
              values   = optional(set(string))
            })))
            match_labels = optional(map(string))
          }))
        })))
        ports = optional(list(object({
          end_port = optional(number)
          port     = optional(string)
          protocol = optional(string)
        })))
      })))
      pod_selector = object({
        match_expressions = optional(list(object({
          key      = optional(string)
          operator = optional(string)
          values   = optional(set(string))
        })))
        match_labels = optional(map(string))
      })
      policy_types = list(string)
    })
  }))
}

