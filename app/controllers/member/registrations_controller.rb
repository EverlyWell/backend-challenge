class Member::RegistrationsController < Devise::RegistrationsController
  after_action :post_registration_jobs, only: :create

  private

  def post_registration_jobs
    member = resource

    member.pull_headings_async
  end
end