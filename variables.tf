variable "protocol" {
    description = "The protocol you want to use."
    default = "email"
}

# below are the required variables

variable "application_name" {
    description = "The application being monitored."
}

variable "notification_endpoint" {
    description = "The notification-endpoint that you want to receive notifications."
}
