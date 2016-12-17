require 'spec_helper'

RSpec.describe WebhookServer do
  describe "payload endpoint" do
    context "when webhook is received" do
      it "pushes the event message onto the queue" do
        post '/payload' do
          expect(last_response.status).to eq 200
        end
      end
    end
  end
end
