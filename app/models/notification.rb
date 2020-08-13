class Notification < ApplicationRecord
  belongs_to :user

  before_save :sent_notification

  private

  def sent_notification
    ActionCable.server.broadcast "notification_channel:#{self.user_id}", message: self.message
  end
end
