require 'rails_helper'

RSpec.describe BroadcastJob, type: :job do
  include ActiveJob::TestHelper
  let(:room) {create(:room)}
  let(:user) {create(:user)}
  let(:message_with_urls) {create(:message, :urls_in_body, room: room, user: user)}
  let(:message_with_images) {create(:message, :images_in_body, room: room, user: user)}

  subject(:job) { described_class.perform_later(message_with_urls) }

  it "queues the job" do
    expect { job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size)
  end

  it "is in default queue" do
    expect(BroadcastJob.new.queue_name).to eq('default')
  end

  it "executes perform" do
    message_parser = double("message_parser")
    allow(message_parser).to receive(:extract_urls!).and_return([])
    expect(MessageParser).to receive(:new).with(message_with_urls).and_return(message_parser)
    perform_enqueued_jobs { job }
  end

  it "executes perform" do
    stub_request(:get, "http://site.com/doc.pdf").
      to_return(:status => 200, :body => "", :headers => {'Content-Type' => 'my/type'})
    perform_enqueued_jobs { job }
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end