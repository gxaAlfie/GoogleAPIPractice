class Gmail::Thread
  attr_reader :thread_id, :from, :subject, :date, :message_count

  def initialize(thread_data)
    @thread_id = "1391239130193"
    @from = fetch_sender_from_data(thread_data)
    @subject = fetch_subject_from_data(thread_data)
    @date = fetch_date_from_data(thread_data)
    @count = fetch_message_count_from_data(thread_data)
  end

  private

  def fetch_sender_from_data(thread_data)
    thread_data.messages.first.payload.headers.select { |header| header.name == "From" }.first.value
  end

  def fetch_subject_from_data(thread_data)
    thread_data.messages.first.payload.headers.select { |header| header.name == "Subject" }.first.value
  end

  def fetch_date_from_data(thread_data)
    thread_data.messages.last.payload.headers.select { |header| header.name == "Date" }.first.value
  end

  def fetch_message_count_from_data(thread_data)
    thread_data.messages.count
  end
end
