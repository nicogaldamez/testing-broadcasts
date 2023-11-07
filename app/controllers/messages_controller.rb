class MessagesController < ApplicationController
  def index
    @messages = Message
      .where(to: current_user)
      .order(created_at: :desc)
  end

  def new
    @message = Message.new
  end

  def create
    message = Message.create(message_params)

    Turbo::StreamsChannel.broadcast_prepend_to(
      message.to,
      :inbox,
      target: :messages,
      partial: 'messages/message',
      locals: { message: message },
    )

    redirect_to messages_path, notice: 'The message was sent.'
  end

  private

  def message_params
    params
      .require(:message)
      .permit(:to_id, :body)
      .merge(from: current_user)
  end
end
