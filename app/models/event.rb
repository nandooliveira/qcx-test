class Event < ApplicationRecord
  EVENT_TYPES = %w[
    ping
    check_run
    check_suite
    commit_comment
    content_reference
    create
    delete
    deploy_key
    deployment
    deployment_status
    fork
    github_app_authorization
    gollum
    installation
    installation_repositories
    issue_comment
    issues
    label
    marketplace_purchase
    member
    membership
    meta
    milestone
    organization
    org_block
    page_build
    project_card
    project_column
    project
    public
    pull_request
    pull_request_review
    pull_request_review_comment
    push
    package
    release
    repository
    repository_import
    repository_vulnerability_alert
    security_advisory
    sponsorship_event
    star
    status
    team
    team_add
    watch
  ].freeze

  validates :event_type, :delivery, :signature, :payload, presence: true
  validates :event_type, inclusion: { in: EVENT_TYPES }
end
