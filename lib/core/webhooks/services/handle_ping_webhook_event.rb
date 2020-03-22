module Core
  module Webhooks
    module Services
      class HandlePingWebhookEvent < ::Core::Webhooks::Services::BaseHandleWebhookEvent
        # this kind of class is only needed if we need to do any diferencial
        # processing for a specific kind of event, it is created only as an example
      end
    end
  end
end
